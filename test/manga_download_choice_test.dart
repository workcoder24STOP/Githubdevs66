import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:shonenx/core/services/one_dm_service.dart';
import 'package:shonenx/features/discovery/presentation/widgets/sheets/download_sheet.dart';
import 'package:shonenx/features/downloads/domain/models/download_task.dart';
import 'package:shonenx/features/downloads/providers/download_provider.dart';
import 'package:shonenx/shared/models/unified_media.dart';
import 'package:shonenx/shared/models/unified_episode.dart';
import 'package:shonenx/source_engine/models/source_info.dart';

class ChoicePaths extends PathProviderPlatform {
  final String path;
  ChoicePaths(this.path);
  @override
  Future<String?> getApplicationSupportPath() async => path;
}

class ChoiceManager extends DownloadManagerNotifier {
  DownloadTask? internal, external;
  @override
  Future<DownloadManagerNotifier> build() async => this;
  @override
  Future<void> startDownload(DownloadTask task) async {
    internal = task;
  }

  @override
  Future<bool> sendMangaToOneDM(DownloadTask task) async {
    external = task;
    return true;
  }
}

void main() {
  for (final external in [false, true]) {
    testWidgets(
      'manga download explicitly selects ${external ? '1DM' : 'internal'} without starting automatically',
      (tester) async {
        final root = (await tester.runAsync(
          () => Directory.systemTemp.createTemp('shonenz-choice-'),
        ))!;
        final original = PathProviderPlatform.instance;
        PathProviderPlatform.instance = ChoicePaths(root.path);
        final manager = ChoiceManager();
        final container = ProviderContainer(
          overrides: [
            downloadManagerProvider.overrideWith(() => manager),
            isOneDMInstalledProvider.overrideWith((ref) async => true),
          ],
        );
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: MaterialApp(
              home: Scaffold(
                body: DownloadSheet(
                  episode: const UnifiedEpisode(id: 'chapter-3', number: 3),
                  source: SourceInfo(
                    id: 'source',
                    name: 'Source',
                    type: SourceType.extension,
                    mediaType: MediaType.MANGA,
                  ),
                  media: UnifiedMedia(
                    id: 'title',
                    type: MediaType.MANGA,
                    title: const MediaTitle(english: 'My title'),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(manager.internal, isNull);
        expect(manager.external, isNull);
        await tester.runAsync(() async {
          await tester.tap(
            find.text(external ? 'Send chapter to 1DM' : 'Download chapter'),
          );
          await Future<void>.delayed(const Duration(milliseconds: 50));
        });
        for (var i = 0; i < 20; i++) {
          await tester.pump(const Duration(milliseconds: 20));
          await tester.runAsync(
            () => Future<void>.delayed(const Duration(milliseconds: 20)),
          );
        }
        final task = external ? manager.external : manager.internal;
        expect(task?.isManga, isTrue);
        expect(task?.itemId, 'chapter-3');
        expect(task?.mediaId, 'title');
        expect(external ? manager.internal : manager.external, isNull);
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox());
        container.dispose();
        PathProviderPlatform.instance = original;
        await tester.runAsync(() => root.delete(recursive: true));
      },
    );
  }
}
