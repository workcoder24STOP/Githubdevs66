import 'package:shonenx/features/offline/catalog_snapshot.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:shonenx/features/offline/manga_downloader.dart';
import 'package:shonenx/shared/models/unified_media.dart';
import 'package:shonenx/source_engine/models/source_info.dart';
import 'package:shonenx/source_engine/source_engine_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shonenx/core/utils/http_x.dart';
import 'package:shonenx/shared/providers/database_provider.dart';
import 'package:shonenx/core/network/http_client.dart';
import 'package:shonenx/core/services/notification_service.dart';
import 'package:shonenx/core/services/one_dm_service.dart';
import 'package:shonenx/features/downloads/domain/download_repository.dart';
import 'package:shonenx/features/downloads/domain/models/download_task.dart';
import 'package:shonenx/features/downloads/providers/download_prefs_provider.dart';
import 'package:shonenx/features/downloads/utils/download_url_helper.dart';
import 'package:shonenx/core/network/stream_server/stream_server.dart';
import 'package:shonenx/core/network/stream_server/hls/hls_stream.dart';

import 'package:byte_me/byte_me.dart' as bm;

final downloadRepositoryProvider = Provider<DownloadRepository>((ref) {
  return DownloadRepository(ref.watch(databaseProvider));
});

final downloadTasksProvider = StreamProvider<List<DownloadTask>>((ref) {
  return ref.watch(downloadRepositoryProvider).watchAllTasks();
});

final downloadManagerProvider =
    AsyncNotifierProvider<DownloadManagerNotifier, DownloadManagerNotifier>(
      DownloadManagerNotifier.new,
    );

class DownloadManagerNotifier extends AsyncNotifier<DownloadManagerNotifier> {
  late bm.ByteMe _manager;
  final Set<String> _starting = {};
  final Map<int, MangaDownloader> _mangaJobs = {};
  int _runningManga = 0;
  final Map<int, Future<void>> _mangaRuns = {};
  final Map<int, Future<void> Function()> _jobSettlers = {};
  final Set<String> _trackedJobs = {};
  final Map<int, int> _lastNotifiedPct = {};
  final Map<int, DateTime> _lastDbWriteTime = {};
  final Map<int, StreamSubscription> _statusSubs = {};
  final Map<int, StreamSubscription> _progressSubs = {};

  static const _foreground = MethodChannel('shonenz/downloads');
  Future<void> _syncForeground() async {
    if (!Platform.isAndroid) return;
    try {
      final active = (await repo.getAll()).any(
        (t) =>
            t.status == DownloadStatus.downloading ||
            (t.status == DownloadStatus.pending &&
                _trackedJobs.contains(t.id.toString())),
      );
      await _foreground.invokeMethod(
        _mangaJobs.isNotEmpty || active ? 'start' : 'stop',
      );
    } on PlatformException catch (_) {
      /* Android can restrict background starts; checkpoints remain recoverable. */
    }
  }

  DownloadRepository get repo => ref.read(downloadRepositoryProvider);

  @override
  Future<DownloadManagerNotifier> build() async {
    final prefs = await ref.read(downloadPrefsProvider.future);
    _manager = bm.ByteMe(maxConcurrentDownloads: prefs.concurrentDownloads);

    ref.onDispose(() {
      for (final job in _mangaJobs.values) {
        job.pause();
      }
      for (final sub in [..._statusSubs.values, ..._progressSubs.values]) {
        sub.cancel();
      }
    });
    for (final recovered in await CatalogSnapshot.recover()) {
      if (await repo.getByCatalogKey(recovered.catalogKey) == null) {
        await repo.putTask(recovered);
      }
    }
    for (final t in await repo.getAll()) {
      if (t.status != DownloadStatus.completed) continue;
      final paths = t.isManga ? t.localPages : [t.savePath];
      if (paths.isEmpty ||
          (await Future.wait(
            paths.map((p) => File(p).exists()),
          )).any((exists) => !exists)) {
        t.status = DownloadStatus.failed;
        t.errorReason =
            'Downloaded files are missing. Import or download again.';
        await CatalogSnapshot.remove(t);
        await repo.putTask(t);
      }
    }
    final unfinished = await repo.getUnfinishedTasks();
    for (final t in unfinished) {
      if (t.status == DownloadStatus.downloading) {
        t.status = DownloadStatus.pending;
        await repo.putTask(t);
      }

      // Auto-resume pending tasks
      if (t.status == DownloadStatus.pending) {
        unawaited(startDownload(t).catchError((Object _) {}));
      }
    }
    return this;
  }

  Future<void> startDownload(DownloadTask task) async {
    final key = task.catalogKey.isEmpty ? task.url : task.catalogKey;
    if (!_starting.add(key)) return;
    try {
      final existing = task.catalogKey.isEmpty
          ? null
          : await repo.getByCatalogKey(task.catalogKey);
      if (existing != null && existing.id != task.id) {
        if (existing.status == DownloadStatus.completed ||
            _trackedJobs.contains(existing.id.toString()) ||
            _mangaJobs.containsKey(existing.id)) {
          return;
        }
        // A newly resolved stream may carry a fresh expiring URL/token.
        if (task.scanlator.isNotEmpty) existing.scanlator = task.scanlator;
        if (task.externalIdsJson != '{}') {
          existing.externalIdsJson = task.externalIdsJson;
        }
        if (!task.isManga) {
          existing.url = task.url;
          existing.headers = task.headers;
          existing.subtitles = task.subtitles;
          existing.requiresProxy = task.requiresProxy;
        }
        task.id = existing.id;
        task = existing;
      }
      if (task.isManga) {
        await _startManga(task);
      } else {
        await _startAnime(task);
      }
    } catch (e) {
      task.status = DownloadStatus.failed;
      task.errorReason = e.toString();
      await repo.putTask(task);
      rethrow;
    } finally {
      _starting.remove(key);
    }
  }

  Future<void> _startManga(DownloadTask task) async {
    final previous = _mangaJobs[task.id];
    if (previous != null) {
      if (!previous.paused) return;
      await _mangaRuns[task.id];
      _mangaJobs.remove(task.id);
    }
    if (task.status == DownloadStatus.completed) return;
    task.status = DownloadStatus.pending;
    task.errorReason = null;
    await repo.putTask(task);
    final job = MangaDownloader(
      task,
      repo,
      resolvePages: () {
        final source = ref.read(
          mangaSourceProvider(
            SourceInfo(
              id: task.sourceId,
              name: task.sourceName,
              type: SourceType.extension,
              mediaType: MediaType.MANGA,
              baseUrl: task.sourceBaseUrl,
            ),
          ),
        );
        return source
            .getPages(task.itemId)
            .timeout(const Duration(seconds: 45));
      },
    );
    _mangaJobs[task.id] = job;
    await _syncForeground();
    final limit = (await ref.read(
      downloadPrefsProvider.future,
    )).concurrentDownloads.clamp(1, 4);
    Future<void> runBounded() async {
      while (_runningManga >= limit && !job.paused) {
        await Future<void>.delayed(const Duration(milliseconds: 100));
      }
      if (job.paused) return;
      _runningManga++;
      try {
        await job.run();
      } finally {
        _runningManga--;
        if (identical(_mangaJobs[task.id], job)) _mangaJobs.remove(task.id);
        _mangaRuns.remove(task.id);
        await _syncForeground();
      }
    }

    _mangaRuns[task.id] = runBounded();
  }

  Future<void> _startAnime(DownloadTask task) async {
    if (task.status == DownloadStatus.completed) return;
    final active = _manager.getTask(task.id.toString());
    if (active?.status == bm.DownloadStatus.downloading ||
        active?.status == bm.DownloadStatus.queued) {
      return;
    }
    await _manager.waitForIdle(task.id.toString());
    await repo.putTask(task);
    final prefs = await ref.read(downloadPrefsProvider.future);
    await File(task.savePath).parent.create(recursive: true);

    // Unwrap local server/bridge URL to target URL
    final unwrapUrl = DownloadUrlHelper.extractUrl(task.url);
    task.headersMap = DownloadUrlHelper.extractHeadersFromUrl(
      task.url,
      task.headersMap,
    );
    task.url = unwrapUrl;
    var transportUrl = unwrapUrl;

    if (task.requiresProxy) {
      final server = ref.read(streamServerProvider);
      final hlsUrl = await server.register(
        HlsStream(
          id: task.id.toString(),
          upstreamUrl: task.url,
          headers: task.headersMap,
        ),
      );
      transportUrl = hlsUrl;
    }

    if (prefs.useOneDM) {
      task.status = DownloadStatus.paused;
      task.errorReason =
          'Sent to 1DM. Import the completed file from Downloads to associate it.';
      await repo.putTask(task);
      final subtitleUrls = <String>[];
      final subtitleFileNames = <String>[];
      final usedSubNames = <String>{};

      for (final sub in task.subtitles) {
        if (sub.url.isEmpty) continue;
        final subUrl = DownloadUrlHelper.extractUrl(sub.url);
        var subFileName = DownloadUrlHelper.formatSubtitleFileName(
          videoFileName: task.fileName,
          language: sub.language,
          label: sub.label,
          subtitleUrl: sub.url,
        );

        if (usedSubNames.contains(subFileName)) {
          final lastDot = subFileName.lastIndexOf('.');
          if (lastDot != -1) {
            final namePart = subFileName.substring(0, lastDot);
            final extPart = subFileName.substring(lastDot);
            var counter = 2;
            while (usedSubNames.contains('$namePart-$counter$extPart')) {
              counter++;
            }
            subFileName = '$namePart-$counter$extPart';
          }
        }

        usedSubNames.add(subFileName);
        subtitleUrls.add(subUrl);
        subtitleFileNames.add(subFileName);
      }

      final success = await OneDMService.instance.download(
        url: transportUrl,
        fileName: task.fileName,
        headers: Map.fromEntries(
          task.headers.map((header) => header.toMapEntry()),
        ),
        subtitleUrls: subtitleUrls,
        subtitleFileNames: subtitleFileNames,
      );
      if (success) return;
    }

    if (DownloadUrlHelper.isTorrent(transportUrl)) {
      throw Exception(
        'Torrent streams cannot be downloaded by the internal download service. Please use 1DM.',
      );
    }

    final isHLS =
        task.isM3u8 ||
        await ref
            .read(httpClientProvider)
            .isHLS(transportUrl, headers: task.headersMap);

    if (isHLS && !task.isM3u8) {
      task.isM3u8 = true;
    }

    if (isHLS &&
        prefs.remuxerPreference == RemuxerPreference.builtin &&
        !task.savePath.endsWith('.mkv')) {
      final dot = task.savePath.lastIndexOf('.');
      task.savePath =
          '${dot > task.savePath.lastIndexOf('/') ? task.savePath.substring(0, dot) : task.savePath}.mkv';
    }
    task.status = DownloadStatus.pending;
    task.errorReason = null;
    task.createdAt = DateTime.now();
    task.updatedAt = DateTime.now();
    await repo.putTask(task);

    final jobId = task.id.toString();
    if (_trackedJobs.contains(jobId)) {
      _manager.resume(jobId);
      return;
    }
    _trackedJobs.add(jobId);
    await _syncForeground();

    bm.DownloadTask job;
    if (isHLS) {
      final isBuiltin = prefs.remuxerPreference == RemuxerPreference.builtin;

      final subTracks = task.subtitles
          .map(
            (s) => bm.SubtitleTrack(
              url: s.url,
              language: s.language,
              title: s.label,
              headers: task.headersMap,
            ),
          )
          .toList();

      job = _manager.downloadHls(
        id: jobId,
        url: Uri.parse(transportUrl),
        savePath: task.savePath,
        maxConcurrentSegments: prefs.concurrentSegments,
        headers: task.headersMap,
        remuxer: isBuiltin
            ? bm.MkvRemuxer(subtitles: subTracks)
            : bm.FfmpegRemuxer(subtitles: subTracks),
        totalSize: task.totalBytes > 0 ? task.totalBytes : null,
      );
    } else {
      job = _manager.download(
        id: jobId,
        url: Uri.parse(transportUrl),
        savePath: task.savePath,
        headers: task.headersMap,
      );
    }

    _listenToJob(task.id, job);
  }

  void _listenToJob(int dbTaskId, bm.DownloadTask job) {
    final notif = NotificationService.instance;
    Future<void> updates = Future<void>.value();
    _jobSettlers[dbTaskId] = () => updates;

    _progressSubs[dbTaskId]?.cancel();
    _statusSubs[dbTaskId]?.cancel();

    _progressSubs[dbTaskId] = job.progressStream.listen((progress) {
      updates = updates
          .then((_) async {
            final now = DateTime.now();
            final lastWrite = _lastDbWriteTime[dbTaskId];

            // Throttle updates (DB read/write & notifications) to once per second,
            // but always process the final 100% completion event.
            if (progress.percent < 1.0 &&
                lastWrite != null &&
                now.difference(lastWrite).inMilliseconds < 1000) {
              return;
            }
            _lastDbWriteTime[dbTaskId] = now;

            final task = await repo.getTaskById(dbTaskId);
            if (task == null || task.status == DownloadStatus.completed) return;

            if (task.status == DownloadStatus.pending) {
              task.status = DownloadStatus.downloading;
              task.errorReason = null;
            }

            task.downloadedBytes = progress.receivedBytes;
            task.totalBytes = progress.totalBytes ?? 0;
            task.progress = progress.percent;
            task.speed = progress.formattedSpeed;
            task.updatedAt = now;
            await repo.putTask(task);

            final pct = (progress.percent * 100).toInt();
            final lastNotified = _lastNotifiedPct[dbTaskId] ?? -1;

            // Update notification if the percentage changed
            if (pct > lastNotified) {
              _lastNotifiedPct[dbTaskId] = pct;
              final title = task.fileName.isNotEmpty
                  ? task.fileName
                  : 'Episode ${task.episodeNumber}';
              await notif.showDownloadProgress(
                id: dbTaskId,
                title: title,
                progress: progress.percent,
              );
            }
          })
          .catchError((Object _) {});
    });

    Future<void> handleStatus(bm.DownloadStatus status) async {
      final task = await repo.getTaskById(dbTaskId);
      if (task == null) return;

      final title = task.fileName.isNotEmpty
          ? task.fileName
          : 'Episode ${task.episodeNumber}';

      switch (status) {
        case bm.DownloadStatus.queued:
          task.status = DownloadStatus.pending;
          task.errorReason = null;
          break;
        case bm.DownloadStatus.downloading:
          task.status = DownloadStatus.downloading;
          task.errorReason = null;
          break;
        case bm.DownloadStatus.paused:
          task.status = DownloadStatus.paused;
          await notif.cancelDownloadNotification(dbTaskId);
          break;
        case bm.DownloadStatus.completed:
          final output = File(task.savePath);
          if (!await output.exists() || await output.length() == 0) {
            task.status = DownloadStatus.failed;
            task.errorReason =
                'The downloaded file is empty or missing. Retry this episode.';
            await repo.putTask(task);
            _cleanupJob(dbTaskId, job.id);
            return;
          }
          task.downloadedBytes = await output.length();
          task.status = DownloadStatus.completed;
          task.errorReason = null;
          if (!task.isM3u8) await _saveSubtitleSidecars(task);
          await notif.showDownloadComplete(id: dbTaskId, title: title);
          task.progress = 1;
          await repo.putTask(task);
          _cleanupJob(dbTaskId, job.id);
          return;
        case bm.DownloadStatus.failed:
          task.status = DownloadStatus.failed;
          task.errorReason = job.error ?? 'Download failed. Tap to retry.';
          await notif.showDownloadFailed(id: dbTaskId, title: title);
          break;
        case bm.DownloadStatus.cancelled:
          task.status = DownloadStatus.canceled;
          await notif.cancelDownloadNotification(dbTaskId);
          break;
      }

      task.updatedAt = DateTime.now();
      await repo.putTask(task);
      await _syncForeground();

      if (status == bm.DownloadStatus.completed ||
          status == bm.DownloadStatus.failed ||
          status == bm.DownloadStatus.cancelled) {
        _cleanupJob(dbTaskId, job.id);
      }
    }

    _statusSubs[dbTaskId] = job.statusStream.listen((status) {
      updates = updates
          .then((_) => handleStatus(status))
          .catchError((Object _) {});
    });

    // If job has already transitioned past queued before subscription, sync status immediately
    if (job.status != bm.DownloadStatus.queued) {
      updates = updates
          .then((_) => handleStatus(job.status))
          .catchError((Object _) {});
    }
  }

  Future<void> _saveSubtitleSidecars(DownloadTask task) async {
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 15);
    var failures = 0;
    try {
      for (var i = 0; i < task.subtitles.length; i++) {
        final sub = task.subtitles[i];
        if (!sub.url.startsWith('http')) continue;
        final uri = Uri.parse(sub.url);
        final suffix = ['srt', 'ass', 'ssa', 'vtt'].firstWhere(
          (ext) => uri.path.toLowerCase().endsWith('.$ext'),
          orElse: () => 'srt',
        );
        final file = File('${task.savePath}.sub$i.$suffix');
        final part = File('${file.path}.part');
        try {
          final request = await client
              .getUrl(uri)
              .timeout(const Duration(seconds: 15));
          task.headersMap.forEach(request.headers.set);
          final response = await request.close().timeout(
            const Duration(seconds: 20),
          );
          if (response.statusCode != 200) {
            throw HttpException('Subtitle HTTP ${response.statusCode}');
          }
          var size = 0;
          final sink = part.openWrite();
          try {
            await for (final chunk in response.timeout(
              const Duration(seconds: 20),
            )) {
              size += chunk.length;
              if (size > 16 * 1024 * 1024) {
                throw StateError('Subtitle exceeds 16 MiB');
              }
              sink.add(chunk);
            }
            await sink.flush();
          } finally {
            await sink.close();
          }
          if (size == 0) throw StateError('Empty subtitle');
          await part.rename(file.path);
          sub.url = file.path;
        } catch (_) {
          failures++;
          if (await part.exists()) await part.delete();
        }
      }
    } finally {
      client.close(force: true);
    }
    if (failures > 0) {
      task.errorReason =
          'Video ready; $failures subtitle file(s) unavailable. Import local subtitle files with the episode.';
    }
  }

  void _cleanupJob(int dbTaskId, String jobId) {
    _trackedJobs.remove(jobId);
    unawaited(_syncForeground());
    _lastNotifiedPct.remove(dbTaskId);
    _lastDbWriteTime.remove(dbTaskId);
    _statusSubs.remove(dbTaskId)?.cancel();
    _progressSubs.remove(dbTaskId)?.cancel();
  }

  Future<void> pauseDownload(int taskId) async {
    _mangaJobs[taskId]?.pause();
    _manager.pause(taskId.toString());
    await _mangaRuns[taskId];
    _mangaJobs.remove(taskId);
    await _manager.waitForIdle(taskId.toString());
    await Future<void>.delayed(Duration.zero);
    await _jobSettlers[taskId]?.call();
    final task = await repo.getTaskById(taskId);
    if (task != null && task.status != DownloadStatus.completed) {
      task.status = DownloadStatus.paused;
      task.errorReason = null;
      await repo.putTask(task);
    }
    await _syncForeground();
  }

  Future<void> cancelDownload(int taskId) async {
    _mangaJobs[taskId]?.cancel();
    _manager.cancel(taskId.toString());
    await _mangaRuns[taskId];
    _mangaJobs.remove(taskId);
    await _manager.waitForIdle(taskId.toString());
    await Future<void>.delayed(Duration.zero);
    await _jobSettlers[taskId]?.call();
    _jobSettlers.remove(taskId);
    _cleanupJob(taskId, taskId.toString());
    await repo.deleteTask(taskId);
    await _syncForeground();
  }
}
