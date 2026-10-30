import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shonenx/features/downloads/domain/models/download_task.dart';
import 'package:shonenx/features/downloads/providers/download_provider.dart';
import 'package:shonenx/features/offline/offline_catalog.dart';
import 'package:shonenx/features/offline/open_download.dart';
import 'package:shonenx/shared/models/unified_media.dart';
import 'package:shonenx/shared/widgets/app_scaffold.dart';

class DownloadsScreen extends ConsumerWidget {
  const DownloadsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(downloadManagerProvider);
    return AppScaffold(
      title: 'Offline library',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showOfflineImport(context, ref),
        icon: const Icon(Icons.file_open_outlined),
        label: const Text('Import files'),
      ),
      body: ref
          .watch(downloadTasksProvider)
          .when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) =>
                Center(child: Text('Could not load downloads: $e')),
            data: (tasks) {
              if (tasks.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'Your downloaded titles live here.\nDownload a chapter or episode, or import files from 1DM with the file picker.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              final groups = <String, List<DownloadTask>>{};
              for (final task in tasks) {
                final key = task.titleKey.isEmpty
                    ? task.mediaId
                    : task.titleKey;
                (groups[key] ??= []).add(task);
              }
              return ListView(
                padding: const EdgeInsets.only(bottom: 100),
                children: [
                  for (final group in groups.values)
                    ListTile(
                      leading: Icon(
                        group.first.isManga
                            ? Icons.menu_book
                            : Icons.movie_outlined,
                      ),
                      title: Text(
                        group.first.mediaTitle.isEmpty
                            ? group.first.fileName
                            : group.first.mediaTitle,
                      ),
                      subtitle: Text(
                        '${group.where((t) => t.status == DownloadStatus.completed).length} available • ${group.length} ${group.first.isManga ? 'chapters' : 'episodes'}',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => OfflineTitleScreen(
                            titleKey: group.first.titleKey,
                            mediaId: group.first.mediaId,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
    );
  }
}

class OfflineTitleScreen extends ConsumerWidget {
  final String titleKey, mediaId;
  final UnifiedMedia? media;
  final bool embedded;
  const OfflineTitleScreen({
    super.key,
    required this.titleKey,
    required this.mediaId,
    this.media,
    this.embedded = false,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks =
        (ref.watch(downloadTasksProvider).value ?? [])
            .where(
              (t) => media != null
                  ? OfflineCatalog.belongsToMedia(t, media!)
                  : titleKey.isEmpty
                  ? t.mediaId == mediaId
                  : t.titleKey == titleKey,
            )
            .toList()
          ..sort((a, b) {
            final season = a.season.compareTo(b.season);
            return season == 0
                ? a.episodeNumber.compareTo(b.episodeNumber)
                : season;
          });
    return Scaffold(
      appBar: embedded
          ? null
          : AppBar(
              title: Text(tasks.isEmpty ? 'Downloads' : tasks.first.mediaTitle),
            ),
      body: tasks.isEmpty
          ? const Center(child: Text('No downloads for this title.'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final t = tasks[index];
                final complete = t.status == DownloadStatus.completed;
                return ListTile(
                  leading: complete
                      ? Icon(
                          t.isManga
                              ? Icons.menu_book
                              : Icons.play_circle_outline,
                        )
                      : SizedBox(
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(
                            value: t.progress.clamp(0, 1),
                          ),
                        ),
                  title: Text(
                    '${t.isManga ? 'Chapter' : 'S${t.season} · Episode'} ${t.episodeNumber} ${t.itemTitle}',
                  ),
                  subtitle: Text(
                    '${t.sourceName}${t.scanlator.isEmpty ? '' : ' · ${t.scanlator}'} • ${t.status.name}${t.errorReason == null ? '' : '\n${t.errorReason}'}',
                  ),
                  isThreeLine: t.errorReason != null,
                  onTap: complete ? () => openDownload(context, t) : null,
                  trailing: PopupMenuButton<String>(
                    itemBuilder: (_) => [
                      if (t.status == DownloadStatus.downloading ||
                          t.status == DownloadStatus.pending)
                        const PopupMenuItem(
                          value: 'pause',
                          child: Text('Pause'),
                        ),
                      if (!complete &&
                          t.status != DownloadStatus.downloading &&
                          !t.imported)
                        const PopupMenuItem(
                          value: 'resume',
                          child: Text('Resume / retry'),
                        ),
                      if (!complete &&
                          t.isManga &&
                          !t.imported &&
                          t.status != DownloadStatus.downloading)
                        const PopupMenuItem(
                          value: '1dm',
                          child: Text('Send chapter to 1DM'),
                        ),
                      if (!complete)
                        PopupMenuItem(
                          value: 'import',
                          child: Text(
                            t.isManga
                                ? 'Import completed 1DM files'
                                : 'Import completed 1DM file',
                          ),
                        ),
                      if (complete && !t.isManga)
                        const PopupMenuItem(
                          value: 'subtitles',
                          child: Text('Add subtitle files'),
                        ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete download'),
                      ),
                    ],
                    onSelected: (action) async {
                      try {
                        final manager = await ref.read(
                          downloadManagerProvider.future,
                        );
                        switch (action) {
                          case 'pause':
                            await manager.pauseDownload(t.id);
                          case 'resume':
                            await manager.startDownload(t);
                          case '1dm':
                            final sent = await manager.sendMangaToOneDM(t);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    sent
                                        ? 'Chapter pages sent to 1DM. Import all completed images into this chapter afterward.'
                                        : '1DM is not installed or could not open the chapter.',
                                  ),
                                ),
                              );
                            }
                          case 'import':
                            if (context.mounted) {
                              await showOfflineImport(context, ref, target: t);
                            }
                          case 'subtitles':
                            final picked = await FilePicker.platform.pickFiles(
                              allowMultiple: true,
                              type: FileType.custom,
                              allowedExtensions: ['srt', 'ass', 'ssa', 'vtt'],
                            );
                            if (picked != null) {
                              await OfflineCatalog.attachSubtitles(
                                ref.read(downloadRepositoryProvider),
                                t,
                                picked.paths.whereType<String>().toList(),
                              );
                            }
                          case 'delete':
                            await manager.cancelDownload(t.id);
                            final entity = t.isManga
                                ? Directory(t.savePath)
                                : File(t.savePath);
                            for (final subtitle in t.subtitles) {
                              if (!subtitle.url.startsWith('http') &&
                                  await File(subtitle.url).exists()) {
                                await File(subtitle.url).delete();
                              }
                            }
                            if (await entity.exists()) {
                              await entity.delete(recursive: t.isManga);
                            }
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('$e')));
                        }
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}

Future<void> showOfflineImport(
  BuildContext context,
  WidgetRef ref, {
  DownloadTask? target,
}) async {
  final title = TextEditingController(text: target?.mediaTitle ?? '');
  final number = TextEditingController(
    text: target?.episodeNumber.toString() ?? '1',
  );
  final season = TextEditingController(text: target?.season.toString() ?? '1');
  var manga = target?.isManga ?? true;
  String? error;
  final accepted = await showDialog<bool>(
    context: context,
    builder: (dialog) => StatefulBuilder(
      builder: (dialog, setState) => AlertDialog(
        title: const Text('Import into title'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select a CBZ/ZIP or ordered images for one chapter. For anime select one video and its subtitle files. Confirm the title and numbering; no title is guessed.',
              ),
              TextField(
                controller: title,
                decoration: const InputDecoration(labelText: 'Title'),
                readOnly: target != null,
              ),
              if (target == null)
                SwitchListTile(
                  title: const Text('Manga chapter'),
                  value: manga,
                  onChanged: (v) => setState(() => manga = v),
                ),
              TextField(
                controller: number,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: manga ? 'Chapter number' : 'Episode number',
                ),
                readOnly: target != null,
              ),
              if (!manga)
                TextField(
                  controller: season,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Season'),
                  readOnly: target != null,
                ),
              if (error != null)
                Text(
                  error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialog, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final n = double.tryParse(number.text),
                  s = int.tryParse(season.text);
              if (title.text.trim().isEmpty ||
                  n == null ||
                  !n.isFinite ||
                  n < 0 ||
                  s == null ||
                  s < 1) {
                setState(() => error = 'Enter a title and valid numbering.');
                return;
              }
              Navigator.pop(dialog, true);
            },
            child: const Text('Choose files'),
          ),
        ],
      ),
    ),
  );
  final titleValue = title.text,
      numberValue = double.tryParse(number.text) ?? 0,
      seasonValue = int.tryParse(season.text) ?? 1;
  title.dispose();
  number.dispose();
  season.dispose();
  if (accepted != true) return;
  try {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: manga
          ? ['zip', 'cbz', 'jpg', 'jpeg', 'png', 'webp', 'gif', 'avif']
          : [
              'mp4',
              'mkv',
              'webm',
              'avi',
              'mov',
              'm4v',
              'ts',
              'srt',
              'ass',
              'ssa',
              'vtt',
            ],
    );
    if (result == null) return;
    final paths = result.files.map((f) => f.path).whereType<String>().toList();
    if (paths.length != result.files.length) {
      throw StateError('The file provider did not grant access to all files.');
    }
    await OfflineCatalog.importFiles(
      repo: ref.read(downloadRepositoryProvider),
      files: paths,
      title: titleValue,
      manga: manga,
      number: numberValue,
      season: seasonValue,
      target: target,
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Imported into the offline library.')),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Import failed: $e')));
    }
  }
}
