import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:path/path.dart' as p;

import '../download_task.dart';
import '../models.dart';
import '../remux/concat_remuxer.dart';
import '../remux/remuxer.dart';
import 'hls_crypto.dart';
import 'm3u8_parser.dart';

/// Orchestrates the full HLS download pipeline:
/// parse playlist → download segments → decrypt → remux.
class HlsDownloader {
  final HttpClient _client;

  HlsDownloader(this._client);

  /// Executes an HLS download. Updates [task] throughout.
  Future<void> execute(
    DownloadTask task, {
    required Uri url,
    required String savePath,
    Map<String, String>? headers,
    int maxConcurrentSegments = 5,
    Remuxer? remuxer,
    RetryConfig retry = const RetryConfig(),
    int? totalSize,
  }) async {
    final effectiveHeaders = headers ?? {};
    final effectiveRemuxer = remuxer ?? const ConcatRemuxer();

    if (task.status == DownloadStatus.cancelled ||
        task.status == DownloadStatus.paused)
      return;
    task.updateStatus(DownloadStatus.downloading);

    // Deterministic temp directory based on task ID so downloaded segments survive pauses and failures
    final safeTaskId = task.id.replaceAll(RegExp(r'[^a-zA-Z0-9_\-]'), '_');
    final tempDir = Directory(
      p.join(p.dirname(savePath), '.byte_me_hls_$safeTaskId'),
    );
    await tempDir.create(recursive: true);

    bool cancelled = false;
    Completer<void>? pauseCompleter;

    task.attachCancelCallback(() {
      cancelled = true;
      if (pauseCompleter != null && !pauseCompleter!.isCompleted)
        pauseCompleter!.complete();
    });
    try {
      // Parse playlist
      final segments = await M3u8Parser.parse(
        url.toString(),
        effectiveHeaders,
        _client,
      );

      if (cancelled ||
          task.status == DownloadStatus.paused ||
          task.status == DownloadStatus.cancelled)
        throw _CancelledException();
      if (segments.isEmpty) throw StateError('Empty HLS playlist');
      final identity = jsonEncode(segments.map((s) => s.url).toList());
      final indexFile = File(p.join(tempDir.path, 'playlist.json'));
      if (!await indexFile.exists() ||
          await indexFile.readAsString() != identity) {
        await tempDir.delete(recursive: true);
        await tempDir.create(recursive: true);
        await indexFile.writeAsString(identity, flush: true);
      }

      // Download state
      int completedCount = 0;
      int completedBytes = 0;
      int totalBytesReceived = 0;
      final stopwatch = Stopwatch()..start();
      int lastSpeedUpdateMs = 0;
      int lastBytesForSpeed = 0;
      double currentSpeed = 0;

      void emitProgress() {
        final nowMs = stopwatch.elapsedMilliseconds;

        // Update speed calculation every 500ms
        if (nowMs - lastSpeedUpdateMs > 500) {
          final bytesDiff = totalBytesReceived - lastBytesForSpeed;
          final timeDiff = nowMs - lastSpeedUpdateMs;
          currentSpeed = timeDiff > 0 ? (bytesDiff / timeDiff) * 1000 : 0;
          lastBytesForSpeed = totalBytesReceived;
          lastSpeedUpdateMs = nowMs;
        }

        // Estimate total size
        int estimatedTotal = totalSize ?? 0;
        if (estimatedTotal <= 0 && completedCount > 0) {
          final avgPerSegment = completedBytes / completedCount;
          estimatedTotal = (avgPerSegment * segments.length).round();
        }
        if (estimatedTotal < totalBytesReceived) {
          estimatedTotal = totalBytesReceived;
        }

        task.updateProgress(
          DownloadProgress(
            receivedBytes: totalBytesReceived,
            totalBytes: estimatedTotal > 0 ? estimatedTotal : null,
            elapsed: Duration(milliseconds: nowMs),
            bytesPerSecond: currentSpeed,
          ),
        );
      }

      // Cancel/pause wiring
      task.attachCancelCallback(() {
        cancelled = true;
        if (pauseCompleter != null && !pauseCompleter!.isCompleted)
          pauseCompleter!.complete();
      });

      // Concurrent segment download using worker pool pattern
      final segmentIterator = segments.indexed.iterator;
      final segmentFiles = List<File?>.filled(segments.length, null);

      Future<void> worker() async {
        while (segmentIterator.moveNext()) {
          if (cancelled) return;

          // Handle pause
          if (task.status == DownloadStatus.paused) {
            pauseCompleter = Completer<void>();
            await pauseCompleter!.future;
            pauseCompleter = null;
            if (cancelled) return;
          }

          final (index, segment) = segmentIterator.current;
          final segFile = File(p.join(tempDir.path, 'seg_$index.ts'));
          final partFile = File(p.join(tempDir.path, 'seg_$index.ts.part'));

          // Check if segment is already completely downloaded
          if (segFile.existsSync()) {
            final len = segFile.lengthSync();
            if (len > 0) {
              segmentFiles[index] = segFile;
              completedCount++;
              completedBytes += len;
              totalBytesReceived += len;
              emitProgress();
              continue;
            } else {
              try {
                segFile.deleteSync();
              } catch (_) {}
            }
          }

          // Clean up any stale partial segment from a prior failed attempt
          if (partFile.existsSync()) {
            try {
              partFile.deleteSync();
            } catch (_) {}
          }

          // Download segment with retries and adaptive backoff
          bool success = false;
          String? lastErrorMessage;

          for (int attempt = 0; attempt <= retry.maxRetries; attempt++) {
            if (cancelled) return;
            try {
              await _downloadSegment(segment.url, partFile, effectiveHeaders, (
                bytes,
              ) {
                totalBytesReceived += bytes;
                emitProgress();
              });

              if (partFile.existsSync()) {
                await partFile.rename(segFile.path);
              }
              success = true;
              break;
            } catch (e) {
              if (cancelled) return;
              lastErrorMessage = _friendlyErrorMessage(e);

              if (attempt < retry.maxRetries) {
                if (e is RateLimitException) {
                  // Server rate limited: use server Retry-After or exponential backoff with jitter
                  final delay =
                      e.retryAfter ??
                      Duration(
                        milliseconds:
                            2500 * (attempt + 1) + Random().nextInt(1500),
                      );
                  await Future.delayed(delay);
                } else {
                  await Future.delayed(retry.delayFor(attempt + 1));
                }
              }
            }
          }

          if (!success) {
            throw Exception(
              lastErrorMessage ??
                  'Segment $index failed after ${retry.maxRetries} retries',
            );
          }

          segmentFiles[index] = segFile;
          completedCount++;
          completedBytes += segFile.lengthSync();
          emitProgress();
        }
      }

      // Launch worker pool
      final workers = List.generate(maxConcurrentSegments, (_) => worker());
      await Future.wait(workers);

      if (cancelled) {
        throw _CancelledException();
      }

      // Pause support for resume wiring
      task.attachResumeCallback(() {
        if (task.status == DownloadStatus.paused) {
          task.updateStatus(DownloadStatus.downloading);
          if (pauseCompleter != null && !pauseCompleter!.isCompleted)
            pauseCompleter!.complete();
        }
      });

      // Decrypt segments in a background isolate
      final validFiles = <File>[];
      for (int i = 0; i < segments.length; i++) {
        final file = segmentFiles[i];
        if (file == null || !file.existsSync()) {
          throw StateError('Missing segment $i after download');
        }
        validFiles.add(file);
      }

      if (segments.any((s) => s.key != null)) {
        final decryptedPaths = await _decryptInIsolate(
          segments,
          validFiles.map((f) => f.path).toList(),
        );
        validFiles
          ..clear()
          ..addAll(decryptedPaths.map(File.new));
      }

      if (cancelled) throw _CancelledException();

      // Ensure output directory exists
      await File(savePath).parent.create(recursive: true);

      // Remux
      await effectiveRemuxer.remux(validFiles, savePath);
      if (cancelled ||
          task.status == DownloadStatus.paused ||
          task.status == DownloadStatus.cancelled)
        throw _CancelledException();

      // Final progress
      task.updateProgress(
        DownloadProgress(
          receivedBytes: totalBytesReceived,
          totalBytes: totalBytesReceived,
          elapsed: stopwatch.elapsed,
          bytesPerSecond: 0,
        ),
      );
      task.updateStatus(DownloadStatus.completed);
    } on _CancelledException {
      // Normal cancellation flow — status already set
    } catch (e) {
      if (!cancelled) {
        final errorMsg = _friendlyErrorMessage(e);
        task.updateStatus(DownloadStatus.failed, errorMsg);
      }
    } finally {
      // Clean up temp directory ONLY if completed or cancelled permanently.
      // Keep downloaded segments if paused or failed so downloads resume without re-downloading!
      if (task.status == DownloadStatus.completed ||
          task.status == DownloadStatus.cancelled) {
        if (tempDir.existsSync()) {
          try {
            await tempDir.delete(recursive: true);
          } catch (_) {}
        }
      }
    }
  }

  static Future<List<String>> _decryptInIsolate(
    List<HlsSegment> segments,
    List<String> inputPaths,
  ) {
    return Isolate.run(() async {
      final paths = <String>[];
      for (int i = 0; i < segments.length; i++) {
        final segment = segments[i], original = File(inputPaths[i]);
        if (segment.key == null) {
          paths.add(original.path);
          continue;
        }
        final decrypted = HlsCrypto.decrypt(
          await original.readAsBytes(),
          segment.key!,
          segment.iv,
          segment.seq,
        );
        final file = File('${original.path}.decrypted');
        await file.writeAsBytes(decrypted, flush: true);
        paths.add(file.path);
      }
      return paths;
    });
  }

  /// Downloads a single segment file.
  Future<void> _downloadSegment(
    String url,
    File destination,
    Map<String, String> headers,
    void Function(int bytesReceived) onBytesReceived,
  ) async {
    final request = await _client
        .getUrl(Uri.parse(url))
        .timeout(const Duration(seconds: 20));
    headers.forEach((k, v) => request.headers.set(k, v));
    final response = await request.close().timeout(const Duration(seconds: 30));

    if (response.statusCode == 429 || response.statusCode == 503) {
      final retryAfterHeader = response.headers.value('retry-after');
      Duration? retryAfter;
      if (retryAfterHeader != null) {
        final parsed = int.tryParse(retryAfterHeader);
        if (parsed != null && parsed > 0 && parsed <= 60) {
          retryAfter = Duration(seconds: parsed);
        }
      }
      await response.drain<void>();
      throw RateLimitException(response.statusCode, retryAfter);
    }

    if (response.statusCode != 200 && response.statusCode != 206) {
      await response.drain<void>();
      throw HttpException(
        'HTTP ${response.statusCode}: ${response.reasonPhrase}',
      );
    }

    final sink = destination.openWrite();
    var received = 0;
    try {
      await for (final chunk in response.timeout(const Duration(seconds: 30))) {
        received += chunk.length;
        sink.add(chunk);
        onBytesReceived(chunk.length);
      }
      await sink.flush();
      if (received == 0 ||
          (response.contentLength >= 0 &&
              received != response.contentLength &&
              response.compressionState !=
                  HttpClientResponseCompressionState.decompressed)) {
        throw HttpException('Incomplete HLS segment');
      }
    } finally {
      await sink.close();
    }
  }

  static String _friendlyErrorMessage(Object error) {
    if (error is RateLimitException) {
      return 'Rate limited by server (HTTP ${error.statusCode}). The video host throttled concurrent segment requests.';
    }
    final str = error.toString();
    if (str.contains('429')) {
      return 'Rate limited by server (HTTP 429). The video host throttled concurrent requests.';
    }
    if (str.contains('403')) {
      return 'Access forbidden (HTTP 403). The video stream URL expired or was blocked.';
    }
    if (str.contains('404')) {
      return 'Stream not found (HTTP 404). The video file is missing on the remote host.';
    }
    if (str.contains('500') ||
        str.contains('502') ||
        str.contains('503') ||
        str.contains('504')) {
      return 'Remote server error. The video host is temporarily unavailable.';
    }
    if (error is SocketException || str.contains('SocketException')) {
      return 'Connection error: Unable to reach video host. Check your network.';
    }
    if (error is HandshakeException || str.contains('HandshakeException')) {
      return 'SSL/TLS connection error. Failed to establish secure connection.';
    }
    if (error is TimeoutException || str.contains('TimeoutException')) {
      return 'Connection timed out waiting for server response.';
    }
    if (error is FileSystemException || str.contains('FileSystemException')) {
      return 'Disk error: Check storage space and write permissions.';
    }
    return str
        .replaceAll('Exception: ', '')
        .replaceAll('StateError: ', '')
        .replaceAll('HttpException: ', '');
  }
}

class _CancelledException implements Exception {}
