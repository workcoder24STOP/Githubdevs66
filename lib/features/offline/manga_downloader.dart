import 'dart:convert';
import 'dart:async';
import 'package:shonenx/source_engine/models/chapter_page.dart';
import 'package:shonenx/core/network/session_manager.dart';
import 'package:shonenx/core/network/network_config.dart';
import 'package:shonenx/core/utils/image_headers.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:shonenx/features/downloads/domain/download_repository.dart';
import 'package:shonenx/features/downloads/domain/models/download_task.dart';

/// Checkpoint each page; an interrupted .part is never considered readable.
class MangaDownloader {
  final DownloadTask task;
  final DownloadRepository repo;
  final Future<List<ChapterPage>> Function()? resolvePages;
  final _stopped = Completer<void>();
  bool _paused = false;
  bool _cancelled = false;
  bool get paused => _paused;
  void cancel() {
    _cancelled = true;
    pause();
  }

  HttpClient? _client;
  MangaDownloader(this.task, this.repo, {this.resolvePages});
  void pause() {
    _paused = true;
    if (!_stopped.isCompleted) _stopped.complete();
    _client?.close(force: true);
  }

  Future<void> run() async {
    if (_cancelled) return;
    try {
      if (_paused) return;
      if (resolvePages != null) {
        final fresh = await Future.any<List<ChapterPage>>([
          resolvePages!(),
          _stopped.future.then((_) => throw StateError('Download stopped')),
        ]);
        if (_paused) return;
        if (fresh.isEmpty) throw StateError('Source returned no chapter pages');
        // Preserve all URL components: query parameters may identify pages.
        // A changed list cannot safely reuse indexed files from another list.
        String identity(String value) {
          var uri = Uri.parse(value);
          final upstream = uri.queryParameters['imageUrl'];
          if (upstream != null) uri = Uri.parse(upstream);
          return uri.replace(fragment: '').toString();
        }

        final previous = (jsonDecode(task.pagesJson) as List)
            .map((p) => identity(p['url'] as String))
            .toList();
        final next = fresh.map((p) => identity(p.url)).toList();
        if (previous.isNotEmpty &&
            (previous.length != next.length ||
                List.generate(
                  next.length,
                  (i) => i,
                ).any((i) => previous[i] != next[i]))) {
          final folder = Directory(task.savePath);
          if (await folder.exists()) await folder.delete(recursive: true);
          task.localPages = [];
          task.progress = 0;
        }
        task.pagesJson = jsonEncode(
          fresh.map((p) => {'url': p.url, 'headers': p.headers}).toList(),
        );
      }
      final pages = (jsonDecode(task.pagesJson) as List)
          .cast<Map<String, dynamic>>();
      if (pages.isEmpty) throw StateError('No pages to download');
      _client = HttpClient()..connectionTimeout = const Duration(seconds: 20);
      await Directory(task.savePath).create(recursive: true);
      task.status = DownloadStatus.downloading;
      task.errorReason = null;
      await repo.putTask(task);
      final local = <String>[];
      task.downloadedBytes = 0;
      for (var i = 0; i < pages.length; i++) {
        if (_paused) break;
        final file = File(
          p.join(task.savePath, '${i.toString().padLeft(6, '0')}.image'),
        );
        var valid = false;
        if (await file.exists() && await file.length() > 0) {
          final handle = await file.open();
          try {
            valid = _isImage(await handle.read(16));
          } finally {
            await handle.close();
          }
        }
        if (!valid) {
          final partial = File('${file.path}.part');
          Object? lastError;
          for (var attempt = 0; attempt < 3; attempt++) {
            if (_paused) break;
            try {
              final rawUrl = pages[i]['url'] as String;
              final uri = Uri.parse(rawUrl.split('#').first);
              if (uri.scheme != 'https' && uri.scheme != 'http') {
                throw StateError('Unsupported page URI');
              }
              final request = await _client!
                  .getUrl(uri)
                  .timeout(const Duration(seconds: 20));
              final headers =
                  (pages[i]['headers'] as Map?)?.cast<String, String>() ?? {};
              final session = SessionManager();
              final cookies = session.getCookiesSync(uri.toString());
              final merged = <String, String>{
                'User-Agent':
                    session.getUserAgentSync(uri.toString()) ??
                    NetworkConfig.globalUserAgent,
                if (cookies.isNotEmpty) 'Cookie': cookies,
                ...NetworkConfig.globalHeaders,
                ...headers,
                ...decodeUrlHeaders(rawUrl),
              };
              merged.forEach(request.headers.set);
              final response = await request.close().timeout(
                const Duration(seconds: 30),
              );
              if (response.statusCode != 200) {
                throw HttpException(
                  'Page ${i + 1}: HTTP ${response.statusCode}',
                );
              }
              var size = 0;
              final sink = partial.openWrite();
              try {
                await for (final bytes in response.timeout(
                  const Duration(seconds: 30),
                )) {
                  if (_paused) throw StateError('Paused');
                  size += bytes.length;
                  if (size > 64 * 1024 * 1024) {
                    throw StateError('Page exceeds 64 MiB');
                  }
                  sink.add(bytes);
                }
                await sink.flush();
              } finally {
                await sink.close();
              }
              if (size == 0 ||
                  (response.compressionState !=
                          HttpClientResponseCompressionState.decompressed &&
                      response.contentLength >= 0 &&
                      size != response.contentLength)) {
                throw StateError('Incomplete page ${i + 1}');
              }
              final head = await partial.open();
              final magic = await head.read(16);
              await head.close();
              if (!_isImage(magic)) {
                throw StateError('Page ${i + 1} did not return an image');
              }
              await partial.rename(file.path);
              lastError = null;
              break;
            } catch (e) {
              lastError = e;
              if (await partial.exists()) await partial.delete();
              if (!_paused && attempt < 2) {
                await Future<void>.delayed(Duration(seconds: 2 << attempt));
              }
            }
          }
          if (!_paused && lastError != null) throw lastError;
        }
        if (_paused) break;
        local.add(file.path);
        task.localPages = List.of(local);
        task.progress = local.length / pages.length;
        task.downloadedBytes += await file.length();
        await repo.putTask(task);
      }
      task.status = _paused ? DownloadStatus.paused : DownloadStatus.completed;
      if (!_paused) task.progress = 1;
    } catch (e) {
      task.status = _paused ? DownloadStatus.paused : DownloadStatus.failed;
      task.errorReason = _paused ? null : e.toString();
    } finally {
      _client?.close(force: true);
      if (!_cancelled) await repo.putTask(task);
    }
  }

  static bool _isImage(List<int> b) =>
      b.length >= 12 &&
      ((b[0] == 0xff && b[1] == 0xd8) ||
          (b[0] == 137 && b[1] == 80 && b[2] == 78 && b[3] == 71) ||
          ascii.decode(b.take(3).toList(), allowInvalid: true) == 'GIF' ||
          (ascii.decode(b.take(4).toList(), allowInvalid: true) == 'RIFF' &&
              ascii.decode(b.sublist(8, 12), allowInvalid: true) == 'WEBP') ||
          ascii.decode(b.sublist(4, 12), allowInvalid: true) == 'ftypavif');
}
