import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shonenx/features/downloads/presentation/downloads_screen.dart';
import 'package:shonenx/features/downloads/providers/download_provider.dart';
import 'package:shonenx/features/downloads/domain/models/download_task.dart';
import 'package:shonenx/features/reader/domain/reader_mode.dart';
import 'package:shonenx/features/player/domain/player_mode.dart';
import 'package:shonenx/shared/providers/storage_provider.dart';
import 'package:shonenx/shared/models/unified_media.dart';

void main() {
  final fixture = File('test/fixtures/reader-page.png').absolute.path;
  testWidgets(
    'manga title opens a downloaded chapter above the navigation shell',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final task = DownloadTask()
        ..id = 1
        ..mediaId = 'manga-id'
        ..mediaTitle = 'Saved manga'
        ..titleKey = 'title-key'
        ..episodeNumber = 4
        ..isManga = true
        ..localPages = [fixture]
        ..status = DownloadStatus.completed;
      ReaderModeOffline? opened;
      final router = GoRouter(
        routes: [
          ShellRoute(
            builder: (_, __, child) => Scaffold(
              body: child,
              bottomNavigationBar: const Text('Shell navigation'),
            ),
            routes: [
              GoRoute(
                path: '/',
                builder: (_, __) => OfflineTitleScreen(
                  titleKey: '',
                  mediaId: 'manga-id',
                  media: UnifiedMedia(id: 'manga-id', type: MediaType.MANGA),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/reader',
            builder: (_, state) {
              opened = state.extra as ReaderModeOffline;
              return const Scaffold(body: Text('App reader route'));
            },
          ),
        ],
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
            downloadTasksProvider.overrideWith((ref) => Stream.value([task])),
          ],
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.textContaining('Chapter 4'));
      await tester.pumpAndSettle();
      expect(find.text('App reader route'), findsOneWidget);
      expect(find.text('Shell navigation'), findsNothing);
      expect(opened?.task.id, 1);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      router.dispose();
    },
  );
  testWidgets(
    'anime title opens its saved episode with local subtitles and resume position',
    (tester) async {
      final task = DownloadTask()
        ..id = 2
        ..mediaId = 'anime-id'
        ..mediaTitle = 'Saved anime'
        ..titleKey = 'anime-key'
        ..episodeNumber = 3
        ..season = 2
        ..savePath = fixture
        ..playbackMs = 123000
        ..status = DownloadStatus.completed
        ..subtitles = [
          DownloadSubtitle.create(
            url: fixture,
            language: 'en',
            label: 'English',
          ),
        ];
      final another = DownloadTask()
        ..mediaId = 'other-id'
        ..mediaTitle = 'Other anime'
        ..episodeNumber = 99;
      PlayerModeOffline? opened;
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => OfflineTitleScreen(
              titleKey: '',
              mediaId: 'anime-id',
              media: UnifiedMedia(id: 'anime-id', type: MediaType.ANIME),
            ),
          ),
          GoRoute(
            path: '/player',
            builder: (_, state) {
              opened = state.extra as PlayerModeOffline;
              return const Scaffold(body: Text('Local player opened'));
            },
          ),
        ],
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            downloadTasksProvider.overrideWith(
              (ref) => Stream.value([task, another]),
            ),
          ],
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.textContaining('99'), findsNothing);
      await tester.runAsync(() async {
        await tester.tap(find.textContaining('Episode 3'));
        await Future<void>.delayed(const Duration(milliseconds: 100));
      });
      await tester.pumpAndSettle();
      expect(opened?.filePath, fixture);
      expect(opened?.taskId, 2);
      expect(opened?.startPosition.inMilliseconds, 123000);
      expect(opened?.subtitles.single.language, 'en');
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      router.dispose();
    },
  );
}
