import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:archive/archive_io.dart';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shonenx/features/downloads/domain/models/download_task.dart';
import 'package:shonenx/features/downloads/domain/download_repository.dart';
import 'package:shonenx/shared/models/unified_media.dart';
import 'package:shonenx/shared/models/unified_episode.dart';
import 'package:shonenx/source_engine/models/source_info.dart';

/// Metadata is authoritative. Filenames are never used to silently guess a title.
class OfflineCatalog {
  static final Set<String> _imports = {};
  static String key(List<Object?> parts) =>
      sha256.convert(utf8.encode(jsonEncode(parts))).toString();
  static String itemKey(
    UnifiedMedia media,
    SourceInfo source,
    UnifiedEpisode episode,
  ) => key([media.type.id, source.id, episode.id]);
  static void describe(
    DownloadTask task,
    UnifiedMedia media,
    SourceInfo source,
    UnifiedEpisode episode,
  ) {
    task.catalogKey = itemKey(media, source, episode);
    task.titleKey = key([
      media.type.id,
      media.id,
      media.externalIds.anilist,
      media.externalIds.mal,
      media.externalIds.kitsu,
    ]);
    task.mediaId = media.id;
    task.mediaTitle = media.title.getPreferedTitle;
    task.sourceId = source.id;
    task.sourceName = source.name;
    task.sourceBaseUrl = source.baseUrl ?? '';
    task.itemId = episode.id;
    task.itemTitle = episode.title ?? '';
    task.scanlator = episode.scanlator ?? '';
    task.externalIdsJson = jsonEncode(media.externalIds.toMap());
    task.season = episode.season ?? 1;
    task.episodeNumber = episode.number;
    task.isManga = media.type == MediaType.MANGA;
    if (!task.isManga && task.savePath.isNotEmpty) {
      task.savePath = p.join(
        p.dirname(task.savePath),
        '${task.catalogKey}${p.extension(task.savePath)}',
      );
    }
  }

  /// Match explicit identifiers only. Similar titles and episode numbers alone
  /// are insufficient evidence to attach an offline file to another title.
  static bool belongsToMedia(DownloadTask task, UnifiedMedia media) {
    if (task.isManga != (media.type == MediaType.MANGA)) return false;
    if (task.mediaId == media.id &&
        (media.sourceId == null || task.sourceId == media.sourceId)) {
      return true;
    }
    final legacyKey = key([
      media.type.id,
      media.id,
      media.externalIds.anilist,
      media.externalIds.mal,
      media.externalIds.kitsu,
    ]);
    if (task.titleKey == legacyKey) return true;
    try {
      final ids = (jsonDecode(task.externalIdsJson) as Map)
          .cast<String, dynamic>();
      return media.externalIds.toMap().entries.any(
        (e) =>
            e.value != null &&
            e.value.toString().isNotEmpty &&
            ids[e.key] == e.value,
      );
    } catch (_) {
      return false;
    }
  }

  static DownloadTask? forEpisode(
    Iterable<DownloadTask> tasks,
    UnifiedMedia media,
    SourceInfo source,
    UnifiedEpisode episode,
  ) {
    final key = itemKey(media, source, episode);
    return tasks
        .where(
          (t) =>
              belongsToMedia(t, media) &&
              (t.catalogKey == key ||
                  (t.sourceId == source.id &&
                      t.itemId == episode.id &&
                      t.season == (episode.season ?? 1))),
        )
        .firstOrNull;
  }

  static Future<Directory> storage() async {
    final root = await getApplicationSupportDirectory();
    return Directory(p.join(root.path, 'offline')).create(recursive: true);
  }

  static Future<DownloadTask> mangaTask(
    UnifiedMedia media,
    SourceInfo source,
    UnifiedEpisode episode,
  ) async {
    final task = DownloadTask();
    describe(task, media, source, episode);
    final root = await storage();
    task.url = 'chapter:${task.catalogKey}';
    task.savePath = p.join(root.path, task.catalogKey);
    task.fileName = '${task.mediaTitle} — Chapter ${episode.number}';
    return task;
  }

  /// SAF/file_picker grants access, then files are copied into app-owned storage.
  /// A user-selected title and number are required; 1DM has no completion API.
  static Future<DownloadTask> importFiles({
    required DownloadRepository repo,
    required List<String> files,
    required String title,
    required bool manga,
    required double number,
    required int season,
    DownloadTask? target,
  }) async {
    if (files.isEmpty ||
        title.trim().isEmpty ||
        !number.isFinite ||
        number < 0 ||
        season < 1) {
      throw ArgumentError(
        'Select files, a title, season and valid chapter/episode number.',
      );
    }
    var task = target ?? DownloadTask();
    if (target != null && target.status == DownloadStatus.downloading) {
      throw StateError('Pause this download before importing.');
    }
    final canonicalTitle =
        target?.titleKey ?? key(['import', manga, title.trim().toLowerCase()]);
    final identity =
        target?.catalogKey ?? key([canonicalTitle, season, number]);
    final existing = await repo.getByCatalogKey(identity);
    if (existing?.status == DownloadStatus.completed) {
      throw StateError(
        'This chapter/episode is already in your offline library.',
      );
    }
    if (existing != null) task = existing;
    if (!_imports.add(identity)) {
      throw StateError('This item is already being imported.');
    }
    Directory? stage;
    try {
      final root = await storage();
      final destination = p.join(root.path, identity);
      final staging = '$destination.importing';
      stage = Directory(staging);
      if (await stage.exists()) await stage.delete(recursive: true);
      await stage.create(recursive: true);
      final local = await Isolate.run(() => _copyImport(files, staging, manga));
      if (local.isEmpty) throw StateError('No supported complete files found.');
      if (await Directory(destination).exists()) {
        // Never overwrite a completed chapter: the check above is authoritative.
        await Directory(destination).delete(recursive: true);
      }
      await stage.rename(destination);
      task.catalogKey = identity;
      task.titleKey = canonicalTitle;
      task.mediaTitle = title.trim();
      task.mediaId = target?.mediaId ?? canonicalTitle;
      task.sourceId = target?.sourceId ?? 'local-import';
      task.sourceName = target?.sourceName ?? 'Imported files';
      task.itemId = target?.itemId ?? identity;
      task.episodeNumber = number;
      task.season = season;
      task.isManga = manga;
      task.imported = true;
      task.url = target?.url ?? 'import:$identity';
      task.fileName = '$title — ${manga ? 'Chapter' : 'Episode'} $number';
      task.localPages = manga
          ? local.map((n) => p.join(destination, n)).toList()
          : [];
      task.savePath = manga ? destination : p.join(destination, local.first);
      task.subtitles = manga
          ? []
          : local
                .skip(1)
                .map(
                  (n) => DownloadSubtitle.create(
                    url: p.join(destination, n),
                    language: 'und',
                    label: n,
                  ),
                )
                .toList();
      task.status = DownloadStatus.completed;
      task.progress = 1;
      task.errorReason = null;
      await repo.putTask(task);
      return task;
    } catch (_) {
      if (stage != null && await stage.exists()) {
        await stage.delete(recursive: true);
      }
      rethrow;
    } finally {
      _imports.remove(identity);
    }
  }

  static Future<void> attachSubtitles(
    DownloadRepository repo,
    DownloadTask task,
    List<String> files,
  ) async {
    if (task.isManga) {
      throw ArgumentError('Select an episode for subtitle tracks.');
    }
    final folder = Directory(
      p.join((await storage()).path, task.catalogKey, 'subtitles'),
    );
    await folder.create(recursive: true);
    for (final path in files) {
      final file = File(path);
      final extension = p.extension(path).toLowerCase();
      if (!subtitles.contains(extension) ||
          await file.length() == 0 ||
          await file.length() > 16 * 1024 * 1024) {
        throw StateError(
          'Select complete SRT, ASS, SSA or VTT files under 16 MiB.',
        );
      }
      final hash = await sha256.bind(file.openRead()).first;
      final destination = p.join(folder.path, '$hash$extension');
      if (task.subtitles.any((s) => s.url == destination)) continue;
      await file.copy(destination);
      task.subtitles = [
        ...task.subtitles,
        DownloadSubtitle.create(
          url: destination,
          language: 'und',
          label: p.basename(path),
        ),
      ];
    }
    await repo.putTask(task);
  }

  static const images = {'.jpg', '.jpeg', '.png', '.webp', '.gif', '.avif'};
  static const videos = {
    '.mp4',
    '.mkv',
    '.webm',
    '.avi',
    '.mov',
    '.m4v',
    '.ts',
  };
  static const subtitles = {'.srt', '.ass', '.ssa', '.vtt'};
  static int naturalCompare(String a, String b) {
    final pattern = RegExp(r'\d+|\D+');
    final aa = pattern.allMatches(a.toLowerCase()).map((m) => m[0]!).toList();
    final bb = pattern.allMatches(b.toLowerCase()).map((m) => m[0]!).toList();
    for (var i = 0; i < aa.length && i < bb.length; i++) {
      final na = int.tryParse(aa[i]), nb = int.tryParse(bb[i]);
      final c = na != null && nb != null
          ? na.compareTo(nb)
          : aa[i].compareTo(bb[i]);
      if (c != 0) return c;
    }
    return aa.length.compareTo(bb.length);
  }

  static Future<List<String>> _copyImport(
    List<String> files,
    String dest,
    bool manga,
  ) async {
    final result = <String>[];
    final sorted = [...files]..sort(naturalCompare);
    final archives = sorted
        .where((f) => {'.zip', '.cbz'}.contains(p.extension(f).toLowerCase()))
        .toList();
    if (manga && archives.isNotEmpty) {
      if (sorted.length != 1) {
        throw StateError(
          'Import one CBZ/ZIP per chapter, or select its images.',
        );
      }
      final input = InputFileStream(archives.single);
      try {
        final archive = ZipDecoder().decodeStream(input, verify: true);
        final pages =
            archive.files
                .where(
                  (f) =>
                      f.isFile &&
                      images.contains(p.extension(f.name).toLowerCase()) &&
                      !f.name.startsWith('__MACOSX/'),
                )
                .toList()
              ..sort((a, b) => naturalCompare(a.name, b.name));
        if (pages.isEmpty ||
            pages.length > 5000 ||
            pages.fold<int>(0, (n, f) => n + f.size) > 2 * 1024 * 1024 * 1024 ||
            pages.any((f) => f.size > 64 * 1024 * 1024)) {
          throw StateError(
            'Archive is empty or exceeds the page/storage limits.',
          );
        }
        for (var i = 0; i < pages.length; i++) {
          // Generated names prevent ZIP paths, traversal and symlinks escaping storage.
          if (pages[i].isSymbolicLink) {
            throw StateError('Archive contains a symbolic link.');
          }
          final name =
              '${i.toString().padLeft(6, '0')}${p.extension(pages[i].name).toLowerCase()}';
          final output = OutputFileStream(p.join(dest, name));
          try {
            pages[i].writeContent(output);
          } finally {
            await output.close();
          }
          if (await File(p.join(dest, name)).length() == 0) {
            throw StateError('Archive contains an empty page.');
          }
          result.add(name);
        }
      } finally {
        await input.close();
      }
    } else {
      if (!manga &&
          sorted
                  .where((f) => videos.contains(p.extension(f).toLowerCase()))
                  .length !=
              1) {
        throw StateError(
          'Select one episode video and its matching subtitle files.',
        );
      }
      if (!manga) {
        sorted.sort(
          (a, b) => (videos.contains(p.extension(a).toLowerCase()) ? 0 : 1)
              .compareTo(videos.contains(p.extension(b).toLowerCase()) ? 0 : 1),
        );
      }
      for (var i = 0; i < sorted.length; i++) {
        final ext = p.extension(sorted[i]).toLowerCase();
        if (!(manga ? images : {...videos, ...subtitles}).contains(ext)) {
          throw StateError(
            'Unsupported or incomplete file: ${p.basename(sorted[i])}',
          );
        }
        final file = File(sorted[i]);
        if (await file.length() == 0) {
          throw StateError('Empty file: ${p.basename(sorted[i])}');
        }
        final name = '${i.toString().padLeft(6, '0')}$ext';
        await file.copy(p.join(dest, name));
        result.add(name);
      }
    }
    return result;
  }
}
