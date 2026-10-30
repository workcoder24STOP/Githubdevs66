import 'dart:io';
import 'package:shonenx/features/history/domain/models/history_entry.dart';
import 'package:shonenx/features/history/providers/history_provider.dart';
import 'package:shonenx/shared/providers/security_prefs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shonenx/features/downloads/domain/models/download_task.dart';
import 'package:shonenx/features/downloads/providers/download_provider.dart';
import 'package:shonenx/features/reader/presentation/widgets/reader_page_view.dart';
import 'package:shonenx/features/reader/presentation/widgets/reader_webtoon_view.dart';
import 'package:shonenx/features/reader/providers/reader_prefs_provider.dart';
import 'package:shonenx/source_engine/models/chapter_page.dart';

class OfflineReader extends ConsumerStatefulWidget {
  final DownloadTask task;
  const OfflineReader({super.key, required this.task});
  @override
  ConsumerState<OfflineReader> createState() => _OfflineReaderState();
}

class _OfflineReaderState extends ConsumerState<OfflineReader> {
  late int page;
  late PageController controller;
  late List<int> bookmarks;
  late Future<bool> available;
  ReaderDirection? lastDirection;
  final webtoon = GlobalKey<ReaderWebtoonViewState>();
  @override
  void initState() {
    super.initState();
    page = widget.task.localPages.isEmpty
        ? 0
        : widget.task.readingPage.clamp(0, widget.task.localPages.length - 1);
    bookmarks = List.of(widget.task.bookmarks);
    controller = PageController(initialPage: page);
    available = Future.wait(
      widget.task.localPages.map((p) => File(p).exists()),
    ).then((v) => v.isNotEmpty && v.every((b) => b));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void save(int value) {
    if (!mounted) return;
    setState(() => page = value);
    ref
        .read(downloadRepositoryProvider)
        .updateReading(widget.task.id, page, bookmarks: bookmarks);
    if (!ref.read(securityPrefsProvider).incognitoMode) {
      final task = widget.task;
      ref
          .read(historyRepositoryProvider)
          .saveProgress(
            HistoryEntry()
              ..mediaType = 'manga'
              ..mediaId = task.mediaId
              ..mediaTitle = task.mediaTitle
              ..itemNumber = task.episodeNumber
              ..progress = page + 1
              ..total = task.localPages.length
              ..sourceId = task.sourceId
              ..sourceName = task.sourceName
              ..lastUpdated = DateTime.now(),
          );
    }
  }

  void jump(int value) {
    if (ref.read(readerPrefsProvider).direction == ReaderDirection.webtoon) {
      webtoon.currentState?.jumpToPage(value);
    } else if (controller.hasClients) {
      controller.jumpToPage(value);
    }
    save(value);
  }

  Future<void> changeChapter(int offset) async {
    final chapters =
        (await ref.read(downloadRepositoryProvider).getAll())
            .where(
              (t) =>
                  t.isManga &&
                  t.titleKey == widget.task.titleKey &&
                  t.status == DownloadStatus.completed,
            )
            .toList()
          ..sort((a, b) {
            final season = a.season.compareTo(b.season);
            return season != 0
                ? season
                : a.episodeNumber.compareTo(b.episodeNumber);
          });
    final index = chapters.indexWhere((t) => t.id == widget.task.id) + offset;
    if (!mounted) return;
    if (index < 0 || index >= chapters.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No more downloaded chapters in this direction.'),
        ),
      );
      return;
    }
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => OfflineReader(task: chapters[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final prefs = ref.watch(readerPrefsProvider);
    if (lastDirection != null &&
        lastDirection != prefs.direction &&
        prefs.direction != ReaderDirection.webtoon) {
      final old = controller;
      controller = PageController(initialPage: page);
      WidgetsBinding.instance.addPostFrameCallback((_) => old.dispose());
    }
    lastDirection = prefs.direction;
    final pages = widget.task.localPages
        .map((p) => ChapterPage(url: p))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.task.mediaTitle} · Ch. ${widget.task.episodeNumber}',
        ),
        actions: [
          if (bookmarks.isNotEmpty)
            PopupMenuButton<int>(
              tooltip: 'Go to bookmark',
              icon: const Icon(Icons.bookmarks_outlined),
              onSelected: jump,
              itemBuilder: (_) => (List<int>.of(bookmarks)..sort())
                  .map(
                    (p) =>
                        PopupMenuItem(value: p, child: Text('Page ${p + 1}')),
                  )
                  .toList(),
            ),
          IconButton(
            tooltip: 'Bookmark page',
            icon: Icon(
              bookmarks.contains(page) ? Icons.bookmark : Icons.bookmark_border,
            ),
            onPressed: () {
              if (bookmarks.contains(page)) {
                bookmarks.remove(page);
              } else {
                bookmarks.add(page);
              }
              save(page);
            },
          ),
          PopupMenuButton<ReaderDirection>(
            initialValue: prefs.direction,
            onSelected: (v) =>
                ref.read(readerPrefsProvider.notifier).updateDirection(v),
            itemBuilder: (_) => ReaderDirection.values
                .map((d) => PopupMenuItem(value: d, child: Text(d.name)))
                .toList(),
          ),
        ],
      ),
      body: FutureBuilder<bool>(
        future: available,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data != true) {
            return const Center(
              child: Text(
                'Downloaded pages are missing. Import or download this chapter again.',
              ),
            );
          }
          if (prefs.direction == ReaderDirection.webtoon) {
            return SizedBox.expand(
              child: ReaderWebtoonView(
                key: webtoon,
                pages: pages,
                initialPage: page,
                scaleType: ReaderScaleType.fitWidth,
                textColor: Theme.of(context).colorScheme.onSurface,
                onPageChanged: save,
              ),
            );
          }
          return ReaderPageView(
            pages: pages,
            controller: controller,
            direction: prefs.direction,
            scaleType: prefs.scaleType,
            textColor: Theme.of(context).colorScheme.onSurface,
            onPageChanged: save,
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          children: [
            IconButton(
              tooltip: 'Previous downloaded chapter',
              onPressed: () => changeChapter(-1),
              icon: const Icon(Icons.skip_previous),
            ),
            Expanded(
              child: Slider(
                value: page.toDouble(),
                max: (pages.length > 1 ? pages.length - 1 : 1).toDouble(),
                onChanged: pages.length < 2
                    ? null
                    : (v) {
                        jump(v.toInt());
                      },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text('${page + 1}/${pages.length}'),
            ),
            IconButton(
              tooltip: 'Next downloaded chapter',
              onPressed: () => changeChapter(1),
              icon: const Icon(Icons.skip_next),
            ),
          ],
        ),
      ),
    );
  }
}
