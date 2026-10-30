import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:byte_me/src/engine/download_engine.dart' as engine;
import 'package:byte_me/byte_me.dart' as bm;
import 'package:byte_me/src/hls/hls_downloader.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:shonenx/features/downloads/domain/download_repository.dart';
import 'package:shonenx/features/downloads/domain/models/download_task.dart';
import 'package:shonenx/features/offline/manga_downloader.dart';
import 'package:shonenx/features/offline/offline_catalog.dart';
import 'package:shonenx/shared/models/unified_media.dart';
import 'package:shonenx/shared/models/unified_episode.dart';
import 'package:shonenx/source_engine/models/source_info.dart';

class MemoryRepo implements DownloadRepository {
  int writes = 0;
  @override
  Future<void> putTask(DownloadTask task) async {
    writes++;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FailOnceRemuxer implements bm.Remuxer {
  bool fail = true;
  @override
  Future<void> remux(List<File> segments, String output) async {
    if (fail) {
      fail = false;
      throw StateError('Synthetic remux interruption');
    }
    await File(output).writeAsBytes(await segments.first.readAsBytes());
  }
}

void main() {
  late Directory root;
  late HttpServer server;
  late HttpClient client;
  setUp(() async {
    root = await Directory.systemTemp.createTemp('shonenz-download-test-');
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    client = HttpClient();
  });
  tearDown(() async {
    client.close(force: true);
    await server.close(force: true);
    await root.delete(recursive: true);
  });
  Uri url(String path) => Uri.parse('http://127.0.0.1:${server.port}$path');
  test(
    'manga checkpoints pages and re-downloads a corrupt checkpoint',
    () async {
      final image = await File('test/fixtures/reader-page.png').readAsBytes();
      var requests = 0;
      server.listen((r) async {
        requests++;
        r.response.add(image);
        await r.response.close();
      });
      final task = DownloadTask()
        ..savePath = root.path
        ..isManga = true
        ..pagesJson = jsonEncode([
          {'url': url('/1').toString()},
          {'url': url('/2').toString()},
        ]);
      final repo = MemoryRepo();
      await MangaDownloader(task, repo).run();
      expect(task.status, DownloadStatus.completed);
      expect(task.localPages.length, 2);
      expect(requests, 2);
      await File(task.localPages.first).writeAsString('not an image');
      task.status = DownloadStatus.paused;
      await MangaDownloader(task, repo).run();
      expect(task.status, DownloadStatus.completed);
      expect(requests, 3);
      expect(await File(task.localPages.first).readAsBytes(), image);
    },
  );
  test('paused manga queue does not resolve or download pages', () async {
    var resolved = false;
    final task = DownloadTask()..savePath = root.path;
    final job = MangaDownloader(
      task,
      MemoryRepo(),
      resolvePages: () async {
        resolved = true;
        return [];
      },
    );
    job.pause();
    await job.run();
    expect(resolved, isFalse);
  });
  test('empty manga list cannot be completed', () async {
    final task = DownloadTask()..savePath = root.path;
    await MangaDownloader(task, MemoryRepo()).run();
    expect(task.status, DownloadStatus.failed);
  });
  test('anime resume rejects a 416 with an unconfirmed server size', () async {
    final file = File('${root.path}/episode.mp4');
    await file.writeAsBytes([1, 2, 3]);
    server.listen((r) async {
      r.response.statusCode = 416;
      r.response.headers.set('Content-Range', 'bytes */99');
      await r.response.close();
    });
    final task = bm.DownloadTask(id: '1');
    await engine.DownloadEngine(client).execute(
      task,
      url: url('/video'),
      savePath: file.path,
      retry: const bm.RetryConfig(maxRetries: 0),
    );
    expect(task.status, bm.DownloadStatus.failed);
    expect(await file.readAsBytes(), [1, 2, 3]);
  });
  test(
    'anime resume validates range and appends only matching bytes',
    () async {
      final file = File('${root.path}/episode.mp4');
      await file.writeAsBytes([1, 2, 3]);
      server.listen((r) async {
        expect(r.headers.value('range'), 'bytes=3-');
        r.response.statusCode = 206;
        r.response.headers.set('Content-Range', 'bytes 3-5/6');
        r.response.contentLength = 3;
        r.response.add([4, 5, 6]);
        await r.response.close();
      });
      final task = bm.DownloadTask(id: '2');
      await engine.DownloadEngine(client).execute(
        task,
        url: url('/video'),
        savePath: file.path,
        retry: const bm.RetryConfig(maxRetries: 0),
      );
      expect(task.status, bm.DownloadStatus.completed);
      expect(await file.readAsBytes(), [1, 2, 3, 4, 5, 6]);
    },
  );
  test(
    'anime inconsistent 206 range leaves the partial file untouched',
    () async {
      final file = File('${root.path}/episode.mp4');
      await file.writeAsBytes([1, 2, 3]);
      server.listen((r) async {
        r.response.statusCode = 206;
        r.response.headers.set('Content-Range', 'bytes 0-2/6');
        r.response.add([4, 5, 6]);
        await r.response.close();
      });
      final task = bm.DownloadTask(id: '3');
      await engine.DownloadEngine(client).execute(
        task,
        url: url('/video'),
        savePath: file.path,
        retry: const bm.RetryConfig(maxRetries: 0),
      );
      expect(task.status, bm.DownloadStatus.failed);
      expect(await file.readAsBytes(), [1, 2, 3]);
    },
  );
  test(
    'HLS retry after remux failure never decrypts saved segments twice',
    () async {
      final plain = Uint8List.fromList(List.generate(188 * 2, (i) => i % 255));
      final key = Uint8List.fromList(List.generate(16, (i) => i));
      final encrypted = enc.Encrypter(
        enc.AES(enc.Key(key), mode: enc.AESMode.cbc),
      ).encryptBytes(plain, iv: enc.IV(Uint8List(16))).bytes;
      server.listen((r) async {
        if (r.uri.path == '/list.m3u8') {
          r.response.write(
            '#EXTM3U\n#EXT-X-TARGETDURATION:4\n#EXT-X-KEY:METHOD=AES-128,URI="key"\n#EXTINF:4,\nsegment.ts\n#EXT-X-ENDLIST\n',
          );
        } else if (r.uri.path == '/key') {
          r.response.add(key);
        } else {
          r.response.add(encrypted);
        }
        await r.response.close();
      });
      final task = bm.DownloadTask(id: 'hls'),
          remux = FailOnceRemuxer(),
          path = '${root.path}/episode.ts';
      final downloader = HlsDownloader(client);
      await downloader.execute(
        task,
        url: url('/list.m3u8'),
        savePath: path,
        remuxer: remux,
      );
      expect(task.status, bm.DownloadStatus.failed);
      await downloader.execute(
        task,
        url: url('/list.m3u8'),
        savePath: path,
        remuxer: remux,
      );
      expect(task.status, bm.DownloadStatus.completed, reason: task.error);
      expect(await File(path).readAsBytes(), plain);
    },
  );
  test(
    'title mapping uses explicit identity, media type and exact source release',
    () {
      final media = UnifiedMedia(id: 'm1', type: MediaType.MANGA);
      final source = SourceInfo(
        id: 's1',
        name: 'Source',
        type: SourceType.extension,
        mediaType: MediaType.MANGA,
      );
      const ep = UnifiedEpisode(
        id: 'chapter-url',
        number: 1,
        scanlator: 'Group A',
      );
      final task = DownloadTask();
      OfflineCatalog.describe(task, media, source, ep);
      expect(OfflineCatalog.belongsToMedia(task, media), isTrue);
      expect(task.scanlator, 'Group A');
      expect(
        OfflineCatalog.belongsToMedia(
          task,
          UnifiedMedia(id: 'm2', type: MediaType.MANGA),
        ),
        isFalse,
      );
      expect(
        OfflineCatalog.belongsToMedia(
          task,
          UnifiedMedia(id: 'm1', type: MediaType.ANIME),
        ),
        isFalse,
      );
      expect(OfflineCatalog.forEpisode([task], media, source, ep), same(task));
      expect(
        OfflineCatalog.forEpisode(
          [task],
          media,
          source,
          ep.copyWith(id: 'another-scanlator-release'),
        ),
        isNull,
      );
    },
  );
}
