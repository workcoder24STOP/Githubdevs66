import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shonenx/features/downloads/domain/models/download_task.dart';

/// Completed media retain a sidecar so their metadata can be reconstructed if
/// the database is restored without its download rows. No network tokens stored.
class CatalogSnapshot {
  static Future<Directory> _root() async => Directory(
    p.join((await getApplicationSupportDirectory()).path, 'offline-index'),
  ).create(recursive: true);
  static Future<void> write(DownloadTask t) async {
    if (t.catalogKey.isEmpty || t.status != DownloadStatus.completed) return;
    final root = await _root();
    final f = File(p.join(root.path, '${t.catalogKey}.json'));
    final temp = File('${f.path}.tmp');
    await temp.writeAsString(
      jsonEncode({
        'version': 1,
        'key': t.catalogKey,
        'titleKey': t.titleKey,
        'mediaId': t.mediaId,
        'title': t.mediaTitle,
        'sourceId': t.sourceId,
        'sourceName': t.sourceName,
        'itemId': t.itemId,
        'itemTitle': t.itemTitle,
        'number': t.episodeNumber,
        'season': t.season,
        'manga': t.isManga,
        'savePath': t.savePath,
        'fileName': t.fileName,
        'pages': t.localPages,
        'subtitles': t.subtitles
            .map(
              (s) => {'url': s.url, 'language': s.language, 'label': s.label},
            )
            .toList(),
      }),
      flush: true,
    );
    await temp.rename(f.path);
  }

  static Future<void> remove(DownloadTask t) async {
    if (t.catalogKey.isEmpty) return;
    final f = File(p.join((await _root()).path, '${t.catalogKey}.json'));
    if (await f.exists()) await f.delete();
  }

  static Future<List<DownloadTask>> recover() async {
    final result = <DownloadTask>[];
    await for (final file in (await _root()).list()) {
      if (file is! File || !file.path.endsWith('.json')) continue;
      try {
        final m = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
        if (m['version'] != 1 ||
            !RegExp(r'^[a-f0-9]{64}$').hasMatch(m['key'] as String)) {
          continue;
        }
        final t = DownloadTask()
          ..catalogKey = m['key']
          ..titleKey = m['titleKey']
          ..mediaId = m['mediaId']
          ..mediaTitle = m['title']
          ..sourceId = m['sourceId']
          ..sourceName = m['sourceName']
          ..itemId = m['itemId']
          ..itemTitle = m['itemTitle']
          ..episodeNumber = (m['number'] as num).toDouble()
          ..season = m['season']
          ..isManga = m['manga']
          ..savePath = m['savePath']
          ..fileName = m['fileName']
          ..localPages = (m['pages'] as List).cast<String>()
          ..status = DownloadStatus.completed
          ..progress = 1
          ..imported = true
          ..url = 'recovered:${m['key']}';
        t.subtitles = (m['subtitles'] as List)
            .map(
              (s) => DownloadSubtitle.create(
                url: s['url'],
                language: s['language'],
                label: s['label'],
              ),
            )
            .toList();
        result.add(t);
      } catch (_) {
        /* A damaged sidecar is isolated from the rest of the library. */
      }
    }
    return result;
  }
}
