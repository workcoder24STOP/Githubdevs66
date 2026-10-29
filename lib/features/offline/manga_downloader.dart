import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:shonenx/features/downloads/domain/download_repository.dart';
import 'package:shonenx/features/downloads/domain/models/download_task.dart';

/// Checkpoint each page; an interrupted .part is never considered readable.
class MangaDownloader {
  final DownloadTask task;
  final DownloadRepository repo;
  bool _paused = false;
  bool _cancelled = false;
  bool get paused => _paused;
  void cancel() {
    _cancelled = true;
    pause();
  }

  HttpClient? _client;
  MangaDownloader(this.task, this.repo);
  void pause() {
    _paused = true;
    _client?.close(force: true);
  }

  Future<void> run() async {
    if (_cancelled) return;
    final pages = (jsonDecode(task.pagesJson) as List)
        .cast<Map<String, dynamic>>();
    _client = HttpClient()..connectionTimeout = const Duration(seconds: 20);
    try {
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
        if (!await file.exists() || await file.length() == 0) {
          final partial = File('${file.path}.part');
          Object? lastError;
          for (var attempt = 0; attempt < 3; attempt++) {
            if (_paused) break;
            try {
              final uri = Uri.parse(pages[i]['url'] as String);
              if (uri.scheme != 'https' && uri.scheme != 'http') {
                throw StateError('Unsupported page URI');
              }
              final request = await _client!
                  .getUrl(uri)
                  .timeout(const Duration(seconds: 20));
              final headers =
                  (pages[i]['headers'] as Map?)?.cast<String, String>() ?? {};
              headers.forEach(request.headers.set);
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
                  (response.contentLength >= 0 &&
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
