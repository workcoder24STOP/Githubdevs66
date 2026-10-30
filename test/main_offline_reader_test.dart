import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shonenx/features/downloads/domain/download_repository.dart';
import 'package:shonenx/features/downloads/domain/models/download_task.dart';
import 'package:shonenx/features/downloads/providers/download_provider.dart';
import 'package:shonenx/features/history/data/history_repository.dart';
import 'package:shonenx/features/history/domain/models/history_entry.dart';
import 'package:shonenx/features/history/providers/history_provider.dart';
import 'package:shonenx/features/reader/domain/reader_mode.dart';
import 'package:shonenx/features/reader/presentation/reader_screen.dart';
import 'package:shonenx/features/reader/presentation/widgets/reader_app_bar.dart';
import 'package:shonenx/features/reader/presentation/widgets/reader_image.dart';
import 'package:shonenx/features/reader/providers/reader_provider.dart';
import 'package:shonenx/shared/providers/security_prefs_provider.dart';
import 'package:shonenx/shared/providers/storage_provider.dart';
import 'package:shonenx/source_engine/source_engine_provider.dart';

class ReaderRepo implements DownloadRepository {
  final List<DownloadTask> tasks;
  ReaderRepo(this.tasks);
  @override
  Future<DownloadTask?> getTaskById(int id) async =>
      tasks.where((t) => t.id == id).firstOrNull;
  @override
  Future<List<DownloadTask>> getAll() async => tasks;
  @override
  Future<void> updateReading(int id, int page, {List<int>? bookmarks}) async {
    final task = tasks.firstWhere((t) => t.id == id);
    task.readingPage = page;
    if (bookmarks != null) task.bookmarks = List.of(bookmarks);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class ReaderHistory implements HistoryRepository {
  final entries = <HistoryEntry>[];
  @override
  Future<void> saveProgress(HistoryEntry entry) async => entries.add(entry);
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class LocalSecurity extends SecurityPrefsNotifier {
  @override
  SecurityPrefs build() => const SecurityPrefs();
}

Future<ReaderState> loaded(ProviderContainer container, ReaderMode mode) async {
  for (var i = 0; i < 100; i++) {
    final state = container.read(readerProvider(mode));
    if (!state.pages.isLoading) return state;
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
  throw TimeoutException('Offline reader did not settle');
}

void main() {
  final fixture = File('test/fixtures/reader-page.png').absolute.path;
  DownloadTask chapter(int id, double number, {String titleKey = 'title'}) =>
      DownloadTask()
        ..id = id
        ..catalogKey = 'chapter-$id'
        ..titleKey = titleKey
        ..mediaId = titleKey
        ..mediaTitle = 'Offline series'
        ..sourceId = 'removed-extension'
        ..itemId = 'item-$id'
        ..isManga = true
        ..status = DownloadStatus.completed
        ..episodeNumber = number
        ..localPages = List.filled(16, fixture)
        ..readingPage = 15;
  late SharedPreferences prefs;
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });
  test(
    'main reader loads saved pages, clamps resume, isolates title and preserves bookmarks without source access',
    () async {
      final task = chapter(1, 2)
        ..readingPage = 999
        ..bookmarks = [0, 7, 999];
      final repo = ReaderRepo([
        chapter(2, 1),
        task,
        chapter(3, 3),
        chapter(4, 9, titleKey: 'other'),
      ]);
      final history = ReaderHistory();
      var sourceReads = 0;
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          downloadRepositoryProvider.overrideWithValue(repo),
          historyRepositoryProvider.overrideWithValue(history),
          securityPrefsProvider.overrideWith(LocalSecurity.new),
          mangaSourceProvider.overrideWith((ref, info) {
            sourceReads++;
            throw StateError('No source available');
          }),
        ],
      );
      final mode = ReaderModeOffline(task: task);
      final sub = container.listen(readerProvider(mode), (_, __) {});
      try {
        final state = await loaded(container, mode);
        expect(state.pages.requireValue.length, 16);
        expect(state.currentPage, 15);
        expect(state.offlineChapters.map((t) => t.episodeNumber), [1, 2, 3]);
        expect(state.bookmarks, [0, 7]);
        final controller = container.read(readerProvider(mode).notifier);
        controller.setPage(4);
        await controller.toggleBookmark();
        await Future<void>.delayed(const Duration(milliseconds: 20));
        expect(task.readingPage, 4);
        expect(task.bookmarks, [0, 4, 7]);
        expect(history.entries.last.progress, 5);
        expect(sourceReads, 0);
      } finally {
        sub.close();
        container.dispose();
      }
    },
  );
  test(
    'missing downloaded page is an offline error and never falls back to the source',
    () async {
      final task = chapter(1, 1)
        ..localPages = ['/missing-final-update-page.png'];
      final container = ProviderContainer(
        overrides: [
          downloadRepositoryProvider.overrideWithValue(ReaderRepo([task])),
          mangaSourceProvider.overrideWith(
            (ref, info) => throw StateError('Source must not be read'),
          ),
        ],
      );
      final mode = ReaderModeOffline(task: task);
      final sub = container.listen(readerProvider(mode), (_, __) {});
      try {
        final state = await loaded(container, mode);
        expect(state.pages.hasError, isTrue);
        expect(state.pages.error.toString(), contains('missing or empty'));
      } finally {
        sub.close();
        container.dispose();
      }
    },
  );
  testWidgets(
    'downloaded chapter renders inside the actual immersive app reader with shared controls',
    (tester) async {
      final task = chapter(1, 1);
      final repo = ReaderRepo([task]);
      final mode = ReaderModeOffline(task: task);
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          downloadRepositoryProvider.overrideWithValue(repo),
          historyRepositoryProvider.overrideWithValue(ReaderHistory()),
          securityPrefsProvider.overrideWith(LocalSecurity.new),
          mangaSourceProvider.overrideWith(
            (ref, info) => throw StateError('Offline source access'),
          ),
        ],
      );
      late ProviderSubscription<ReaderState> sub;
      await tester.runAsync(() async {
        sub = container.listen(readerProvider(mode), (_, __) {});
        await loaded(container, mode);
      });
      final router = GoRouter(
        initialLocation: '/reader',
        routes: [
          GoRoute(path: '/', builder: (_, __) => const SizedBox()),
          GoRoute(
            path: '/reader',
            builder: (_, __) => ReaderScreen(mode: mode),
          ),
        ],
      );
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      for (var i = 0; i < 15; i++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 30)),
        );
        await tester.pump(const Duration(milliseconds: 30));
      }
      expect(find.byType(ReaderScreen), findsOneWidget);
      expect(find.byType(ReaderAppBar), findsOneWidget);
      expect(find.byType(ReaderImage), findsWidgets);
      expect(
        tester
            .widgetList<RawImage>(find.byType(RawImage))
            .any((i) => i.image != null),
        isTrue,
      );
      expect(find.textContaining('Offline · Ch.'), findsOneWidget);
      expect(find.byTooltip('Reader Settings'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      router.dispose();
      sub.close();
      container.dispose();
    },
  );
}
