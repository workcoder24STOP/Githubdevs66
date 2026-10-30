import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:byte_me/byte_me.dart' as bm;
import 'package:byte_me/src/hls/hls_downloader.dart';
import 'package:shonenx/features/downloads/domain/download_repository.dart';
import 'package:shonenx/features/downloads/domain/models/download_task.dart';
import 'package:shonenx/features/offline/manga_downloader.dart';
import 'package:shonenx/features/offline/manga_handoff.dart';
import 'package:shonenx/features/offline/offline_catalog.dart';
import 'package:shonenx/source_engine/models/chapter_page.dart';

class TransferRepo implements DownloadRepository {
  DownloadTask? saved;
  @override
  Future<void> putTask(DownloadTask task) async {
    saved = task;
  }

  @override
  Future<DownloadTask?> getByCatalogKey(String key) async => saved;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class ImportPaths extends PathProviderPlatform {
  final String path;
  ImportPaths(this.path);
  @override
  Future<String?> getApplicationSupportPath() async => path;
}

void main() {
  late Directory root;
  late HttpServer server;
  late HttpClient client;
  final image = File('test/fixtures/reader-page.png').readAsBytesSync();
  setUp(() async {
    root = await Directory.systemTemp.createTemp('shonenz-final-transfer-');
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    client = HttpClient();
  });
  tearDown(() async {
    client.close(force: true);
    await server.close(force: true);
    await root.delete(recursive: true);
  });
  String url(String path) => 'http://127.0.0.1:${server.port}$path';
  test(
    'manga pool overlaps at most three requests and saves source order after out-of-order completion',
    () async {
      var active = 0, peak = 0;
      final completionOrder = <int>[];
      server.listen((r) async {
        final i = int.parse(r.uri.path.substring(1));
        active++;
        if (active > peak) peak = active;
        await Future<void>.delayed(Duration(milliseconds: i == 0 ? 100 : 15));
        r.response.add([...image, i]);
        await r.response.close();
        completionOrder.add(i);
        active--;
      });
      final task = DownloadTask()
        ..isManga = true
        ..savePath = root.path
        ..pagesJson = jsonEncode(List.generate(6, (i) => {'url': url('/$i')}));
      await MangaDownloader(task, TransferRepo()).run();
      expect(task.status, DownloadStatus.completed, reason: task.errorReason);
      expect(peak, inInclusiveRange(2, 3));
      expect(completionOrder.first, isNot(0));
      expect(task.localPages.length, 6);
      for (var i = 0; i < 6; i++) {
        expect((await File(task.localPages[i]).readAsBytes()).last, i);
      }
    },
  );
  test(
    'manga pause aborts stalled page bodies and keeps a resumable state',
    () async {
      final started = Completer<void>();
      server.listen((r) async {
        r.response.add(image.take(16).toList());
        await r.response.flush();
        if (!started.isCompleted) started.complete();
      });
      final task = DownloadTask()
        ..isManga = true
        ..savePath = root.path
        ..pagesJson = jsonEncode([
          {'url': url('/stalled')},
        ]);
      final downloader = MangaDownloader(task, TransferRepo());
      final running = downloader.run();
      await started.future.timeout(const Duration(seconds: 2));
      downloader.pause();
      await running.timeout(const Duration(seconds: 2));
      expect(task.status, DownloadStatus.paused);
      expect(task.localPages, isEmpty);
    },
  );
  test(
    'HLS pause aborts stalled segment connections without waiting for network timeout',
    () async {
      final started = Completer<void>();
      server.listen((r) async {
        if (r.uri.path == '/playlist') {
          r.response.write(
            '#EXTM3U\n#EXT-X-TARGETDURATION:5\n#EXTINF:5,\n${url('/segment')}\n#EXT-X-ENDLIST\n',
          );
          await r.response.close();
        } else {
          r.response.add([1, 2]);
          await r.response.flush();
          if (!started.isCompleted) started.complete();
        }
      });
      final task = bm.DownloadTask(id: 'pause');
      final running = HlsDownloader(client).execute(
        task,
        url: Uri.parse(url('/playlist')),
        savePath: '${root.path}/episode.mkv',
        retry: const bm.RetryConfig(maxRetries: 0),
      );
      await started.future.timeout(const Duration(seconds: 2));
      task.pause();
      await running.timeout(const Duration(seconds: 2));
      expect(task.status, bm.DownloadStatus.paused);
      expect(await File('${root.path}/episode.mkv').exists(), isFalse);
    },
  );
  test(
    '1DM manga plan preserves order, unique names and source headers; mixed headers are rejected',
    () {
      final task = DownloadTask()..catalogKey = 'abcdef1234567890';
      final pages = [
        ChapterPage(
          url: url('/1.png'),
          headers: {'Referer': 'https://source.test'},
        ),
        ChapterPage(
          url: url('/2.webp'),
          headers: {'referer': 'https://source.test'},
        ),
      ];
      final plan = MangaHandoff.prepare(task, pages);
      expect(plan.names, [
        'SZ-abcdef123456-00001.png',
        'SZ-abcdef123456-00002.webp',
      ]);
      expect(plan.urls, pages.map((p) => p.url));
      expect(plan.headers['referer'], 'https://source.test');
      expect(jsonDecode(plan.pagesJson).length, 2);
      expect(
        () => MangaHandoff.prepare(task, [
          pages.first,
          ChapterPage(
            url: url('/3'),
            headers: {'Referer': 'https://different.test'},
          ),
        ]),
        throwsStateError,
      );
    },
  );
  test(
    'damaged import identities cannot address the storage root or another folder',
    () async {
      final marker = File('${root.path}/keep.png');
      await marker.writeAsBytes(image);
      for (final identity in ['', '..', '../outside', '/absolute']) {
        final target = DownloadTask()
          ..catalogKey = identity
          ..titleKey = 'title';
        await expectLater(
          OfflineCatalog.importFiles(
            repo: TransferRepo(),
            files: [marker.path],
            title: 'Title',
            manga: true,
            number: 1,
            season: 1,
            target: target,
          ),
          throwsArgumentError,
        );
        expect(await marker.readAsBytes(), image);
      }
    },
  );
  test(
    '1DM import rejects missing pages and damaged images, then associates the complete ordered chapter',
    () async {
      final original = PathProviderPlatform.instance;
      PathProviderPlatform.instance = ImportPaths(root.path);
      try {
        final a = File('${root.path}/SZ-test-00001.png');
        final b = File('${root.path}/SZ-test-00002.png');
        await a.writeAsBytes(image);
        await b.writeAsBytes(image);
        final target = DownloadTask()
          ..id = 8
          ..catalogKey = 'chapter-eight'
          ..titleKey = 'title-eight'
          ..mediaId = 'media-eight'
          ..sourceId = 'extension-eight'
          ..itemId = 'chapter-eight'
          ..isManga = true
          ..status = DownloadStatus.paused
          ..pagesJson = '[{},{}]';
        final repo = TransferRepo();
        Future<DownloadTask> importing(List<String> files) =>
            OfflineCatalog.importFiles(
              repo: repo,
              files: files,
              title: 'My title',
              manga: true,
              number: 8,
              season: 1,
              target: target,
            );
        await expectLater(importing([a.path]), throwsStateError);
        await b.writeAsString('<html>blocked</html>');
        await expectLater(importing([a.path, b.path]), throwsStateError);
        await b.writeAsBytes([...image, 2]);
        final task = await importing([b.path, a.path]);
        expect(task.status, DownloadStatus.completed);
        expect(task.mediaId, 'media-eight');
        expect(task.sourceId, 'extension-eight');
        expect(task.localPages.length, 2);
        expect(await File(task.localPages.first).readAsBytes(), image);
        expect((await File(task.localPages.last).readAsBytes()).last, 2);
      } finally {
        PathProviderPlatform.instance = original;
      }
    },
  );
}
