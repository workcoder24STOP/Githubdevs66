import 'dart:async';
import 'dart:math' as math;
import 'package:shonenx/shared/models/unified_media.dart';
import 'package:shonenx/source_engine/providers/media_source.dart';

/// Conservative matching: uncertain titles remain available for manual choice.
class MediaMatchService {
  final MediaSource _mediaSource;
  final MediaType _type;
  static final _cache = <String, ({DateTime at, List<UnifiedMedia> results})>{};
  MediaMatchService(this._mediaSource, this._type);

  static String normalize(String title) => title
      .toLowerCase()
      .replaceAll(RegExp(r'[^\p{L}\p{N}]+', unicode: true), ' ')
      .trim();
  static int season(String title) {
    final m = RegExp(
      r'(?:season\s*|\bs)(\d+)\b|\b(\d+)(?:st|nd|rd|th)\s+season',
      caseSensitive: false,
    ).firstMatch(title);
    return int.tryParse(m?.group(1) ?? m?.group(2) ?? '') ?? 1;
  }

  static double similarity(String a, String b) {
    if (season(a) != season(b)) return 0;
    final aa = normalize(a), bb = normalize(b);
    if (aa.isEmpty || bb.isEmpty) return 0;
    if (aa == bb) return 1;
    final x = aa.split(' ').toSet(), y = bb.split(' ').toSet();
    return x.intersection(y).length / x.union(y).length;
  }

  static List<String> aliases(MediaTitle title) => [
    title.english,
    title.romaji,
    title.native,
    title.getPreferedTitle,
  ].whereType<String>().where((t) => t.trim().isNotEmpty).toSet().toList();

  Future<List<UnifiedMedia>> _search(String query) async {
    final key = '${_mediaSource.sourceInfo.id}|${_type.id}|${normalize(query)}';
    final cached = _cache[key];
    if (cached != null &&
        DateTime.now().difference(cached.at) < const Duration(minutes: 10)) {
      return cached.results;
    }
    final results = await _mediaSource
        .search(query, _type)
        .timeout(const Duration(seconds: 15));
    if (_cache.length >= 100) _cache.remove(_cache.keys.first);
    _cache[key] = (at: DateTime.now(), results: results);
    return results;
  }

  Future<UnifiedMedia?> findBestMatch(MediaTitle mediaTitle) async {
    final targets = aliases(mediaTitle);
    final found = <String, UnifiedMedia>{};
    // A bounded pair of queries preserves source rate limits.
    for (var offset = 0; offset < targets.length; offset += 2) {
      final batch = targets.skip(offset).take(2);
      final results = await Future.wait(
        batch.map((q) async {
          try {
            return await _search(q);
          } catch (_) {
            return <UnifiedMedia>[];
          }
        }),
      );
      for (final group in results) {
        for (final m in group) {
          found[m.id] = m;
        }
      }
      final ranked = found.values.map((m) {
        var score = 0.0;
        for (final a in aliases(m.title)) {
          for (final b in targets) {
            score = math.max(score, similarity(a, b));
          }
        }
        return (media: m, score: score);
      }).toList()..sort((a, b) => b.score.compareTo(a.score));
      if (ranked.isNotEmpty &&
          ranked.first.score >= 0.92 &&
          (ranked.length == 1 || ranked.first.score - ranked[1].score >= 0.12)) {
        return ranked.first.media;
      }
    }
    return null;
  }
}
