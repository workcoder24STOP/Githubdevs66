import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:shonenx/features/downloads/providers/download_provider.dart';
import 'package:shonenx/features/downloads/domain/models/download_task.dart';
import 'package:shonenx/features/offline/offline_catalog.dart';
import 'package:shonenx/features/history/domain/models/history_entry.dart';
import 'package:shonenx/features/history/providers/history_provider.dart';
import 'package:shonenx/features/reader/domain/reader_mode.dart';
import 'package:shonenx/shared/models/unified_media.dart';
import 'package:shonenx/features/tracking/engine/sync_engine.dart';
import 'package:shonenx/shared/providers/security_prefs_provider.dart';
import 'package:shonenx/source_engine/models/chapter_page.dart';
import 'package:shonenx/source_engine/source_engine_provider.dart';

class ReaderState {
  final ReaderMode mode;
  final AsyncValue<List<ChapterPage>> pages;
  final int currentPage;
  final int totalPages;
  final bool showOverlay;
  final DownloadTask? localTask;
  final List<DownloadTask> offlineChapters;
  final List<int> bookmarks;

  const ReaderState({
    required this.mode,
    this.pages = const AsyncValue.loading(),
    this.currentPage = 0,
    this.totalPages = 0,
    this.showOverlay = false,
    this.localTask,
    this.offlineChapters = const [],
    this.bookmarks = const [],
  });

  ReaderState copyWith({
    ReaderMode? mode,
    AsyncValue<List<ChapterPage>>? pages,
    int? currentPage,
    int? totalPages,
    bool? showOverlay,
    DownloadTask? localTask,
    List<DownloadTask>? offlineChapters,
    List<int>? bookmarks,
  }) {
    return ReaderState(
      mode: mode ?? this.mode,
      pages: pages ?? this.pages,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      showOverlay: showOverlay ?? this.showOverlay,
      localTask: localTask ?? this.localTask,
      offlineChapters: offlineChapters ?? this.offlineChapters,
      bookmarks: bookmarks ?? this.bookmarks,
    );
  }
}

class ReaderNotifier extends Notifier<ReaderState> {
  late final ReaderMode arg;

  ReaderNotifier(this.arg);

  @override
  ReaderState build() {
    final startPage = arg.startPosition == -1
        ? 0
        : (arg.startPosition > 0 ? arg.startPosition - 1 : 0);

    Future.microtask(() => _fetchPages(arg));

    return ReaderState(
      mode: arg,
      currentPage: startPage,
      totalPages: 0,
      showOverlay: false,
    );
  }

  Future<void> _fetchPages(ReaderMode mode) async {
    state = state.copyWith(pages: const AsyncValue.loading());
    try {
      final repo = ref.read(downloadRepositoryProvider);
      final local = mode is ReaderModeOffline
          ? (await repo.getTaskById(mode.task.id) ?? mode.task)
          : await repo.getByCatalogKey(
              OfflineCatalog.itemKey(mode.media, mode.sourceInfo, mode.episode),
            );
      final List<ChapterPage> pageList;
      var offlineChapters = <DownloadTask>[];
      if (mode is ReaderModeOffline ||
          local?.status == DownloadStatus.completed) {
        if (local == null ||
            !local.isManga ||
            local.status != DownloadStatus.completed ||
            local.localPages.isEmpty) {
          throw StateError('This chapter has no completed downloaded pages.');
        }
        pageList = local.localPages.map((p) => ChapterPage(url: p)).toList();
        for (final page in pageList) {
          final file = File(page.url);
          if (!await file.exists() || await file.length() == 0) {
            throw StateError(
              'Downloaded page is missing or empty. Import or download this chapter again.',
            );
          }
        }
        if (mode is ReaderModeOffline) {
          offlineChapters =
              (await repo.getAll())
                  .where(
                    (t) =>
                        t.isManga &&
                        t.status == DownloadStatus.completed &&
                        (local.titleKey.isNotEmpty
                            ? t.titleKey == local.titleKey
                            : t.mediaId == local.mediaId &&
                                  t.sourceId == local.sourceId),
                  )
                  .toList()
                ..sort((a, b) {
                  final season = a.season.compareTo(b.season);
                  return season != 0
                      ? season
                      : a.episodeNumber.compareTo(b.episodeNumber);
                });
        }
      } else {
        final source = ref.read(mangaSourceProvider(mode.sourceInfo));
        pageList = await source
            .getPages(mode.episode.id)
            .timeout(const Duration(seconds: 45));
      }
      if (!ref.mounted) return;

      if (pageList.isEmpty) {
        state = state.copyWith(
          pages: AsyncValue.error(
            Exception('No pages found for this chapter.'),
            StackTrace.current,
          ),
        );
        return;
      }

      final startPage = mode.startPosition == -1
          ? pageList.length - 1
          : (mode.startPosition > 0 ? mode.startPosition - 1 : 0).clamp(
              0,
              pageList.length - 1,
            );

      state = state.copyWith(
        pages: AsyncValue.data(pageList),
        totalPages: pageList.length,
        localTask: local?.status == DownloadStatus.completed ? local : null,
        offlineChapters: offlineChapters,
        bookmarks:
            local?.bookmarks
                .where((p) => p >= 0 && p < pageList.length)
                .toList() ??
            [],
        currentPage: startPage,
      );

      _saveHistory(startPage, pageList.length);
    } catch (e, st) {
      if (!ref.mounted) return;
      state = state.copyWith(pages: AsyncValue.error(e, st));
    }
  }

  void setPage(int page) {
    if (page < 0 || (state.totalPages > 0 && page >= state.totalPages)) return;
    if (state.currentPage == page) return;

    state = state.copyWith(currentPage: page);
    _saveHistory(page, state.totalPages);
  }

  void toggleOverlay() {
    state = state.copyWith(showOverlay: !state.showOverlay);
  }

  void setOverlay(bool show) {
    state = state.copyWith(showOverlay: show);
  }

  void retry() {
    _fetchPages(arg);
  }

  Future<void> toggleBookmark() async {
    final task = state.localTask;
    if (task == null) return;
    final marks = List<int>.of(state.bookmarks);
    marks.contains(state.currentPage)
        ? marks.remove(state.currentPage)
        : marks.add(state.currentPage);
    marks.sort();
    state = state.copyWith(bookmarks: marks);
    await ref
        .read(downloadRepositoryProvider)
        .updateReading(task.id, state.currentPage, bookmarks: marks);
  }

  void _saveHistory(int pageIndex, int total) {
    _persistHistory(pageIndex, total).catchError((Object _) {});
  }

  Future<void> _persistHistory(int pageIndex, int total) async {
    if (total == 0) return;
    final local = state.localTask;
    if (local != null) {
      await ref
          .read(downloadRepositoryProvider)
          .updateReading(local.id, pageIndex, bookmarks: state.bookmarks);
    }
    if (!ref.mounted || ref.read(securityPrefsProvider).incognitoMode) return;
    final savedPageNumber = pageIndex + 1;
    final entry = HistoryEntry()
      ..mediaType = MediaType.MANGA.id
      ..itemNumber = arg.episode.number
      ..mediaId = arg.media.id
      ..mediaIdMal = arg.media.idMal
      ..externalIds = arg.media.externalIds
      ..mediaTitle = arg.media.title.getPreferedTitle
      ..cover = arg.media.cover
      ..banner = arg.media.banner
      ..progress = savedPageNumber
      ..total = total
      ..sourceId = arg.sourceInfo.id
      ..sourceName = arg.sourceInfo.name
      ..providerId = arg.media.providerId != arg.media.id
          ? arg.media.providerId
          : null
      ..lastUpdated = DateTime.now();

    await ref.read(historyRepositoryProvider).saveProgress(entry);
    // Local reading must not start tracker/network requests while offline.
    if (!ref.mounted || arg is ReaderModeOffline) return;
    ref
        .read(syncEngineProvider)
        .processReading(
          media: arg.media,
          chapterNumber: arg.episode.number,
          positionPage: savedPageNumber,
          totalPages: total,
        );
  }
}

final readerProvider = NotifierProvider.autoDispose
    .family<ReaderNotifier, ReaderState, ReaderMode>(
      ReaderNotifier.new,
      name: 'readerProvider',
    );
