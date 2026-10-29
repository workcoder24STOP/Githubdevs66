import 'dart:async';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart'
    as bridge;
import 'package:shonenx/core/utils/app_logger.dart';
import 'package:shonenx/shared/models/unified_chapter.dart';
import 'package:shonenx/source_engine/models/chapter_page.dart';
import 'package:shonenx/source_engine/providers/manga_source.dart';
import 'base_source_adapter.dart';

class MangaSourceAdapter extends BaseSourceAdapter implements MangaSource {
  MangaSourceAdapter({required super.sourceInfo, required super.source});

  @override
  final log = AppLogger.scope(MangaSourceAdapter);

  @override
  Future<List<UnifiedChapter>> getChapters(
    String mangaId, {
    bool forceRefresh = false,
  }) async {
    final methodLog = log.child('getChapters');
    try {
      final detail = await getRawDetail(
        mangaId,
      ).timeout(const Duration(seconds: 45));

      methodLog.d('chapters=${detail.episodes?.length ?? 0}');

      return (detail.episodes ?? [])
          .where((e) => e.url?.isNotEmpty ?? false)
          .map(
            (e) => UnifiedChapter(
              id: '${e.url!}|${e.episodeNumber}',
              title: e.name,
              number: double.tryParse(e.episodeNumber) ?? 0.0,
              scanlator: e.scanlator,
              uploadDate: e.dateUpload,
            ),
          )
          .toList()
        ..sort((a, b) {
          final n = a.number.compareTo(b.number);
          return n != 0 ? n : a.id.compareTo(b.id);
        });
    } catch (e, st) {
      methodLog.e('getChapters failed', e, st);
      rethrow;
    }
  }

  @override
  Future<List<ChapterPage>> getPages(String chapterId) async {
    final methodLog = log.child('getPages');
    try {
      methodLog.i('chapterId=$chapterId');
      final separator = chapterId.lastIndexOf('|');
      final url = separator < 0 ? chapterId : chapterId.substring(0, separator);
      final epNum = separator < 0 ? '1' : chapterId.substring(separator + 1);

      final pages = await source.methods
          .getPageList(bridge.DEpisode(url: url, episodeNumber: epNum))
          .timeout(const Duration(seconds: 45));

      methodLog.d('pages=${pages.length}');
      return pages.map((e) {
        final headers = {
          if (sourceInfo.baseUrl?.isNotEmpty ?? false)
            'referer': '${sourceInfo.baseUrl}/',
          'user-agent':
              'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36',
          ...{
            for (final h in (e.headers ?? <String, String>{}).entries)
              h.key.toLowerCase(): h.value,
          },
        };
        return ChapterPage(url: e.url, headers: headers);
      }).toList();
    } catch (e, st) {
      methodLog.e('getPages failed', e, st);
      rethrow;
    }
  }

  @override
  Future<List<String>> getFilterGenres() async {
    return [];
  }

  @override
  Future<List<String>> getFilterTags() async {
    return [];
  }
}
