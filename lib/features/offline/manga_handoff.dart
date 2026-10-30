import 'dart:convert';
import 'package:shonenx/core/network/network_config.dart';
import 'package:shonenx/core/network/session_manager.dart';
import 'package:shonenx/core/utils/image_headers.dart';
import 'package:shonenx/features/downloads/domain/models/download_task.dart';
import 'package:shonenx/source_engine/models/chapter_page.dart';

/// One chapter per explicit Android handoff. Header sets must agree because
/// 1DM's existing batch intent accepts one header map for the whole request.
class MangaHandoff {
  final List<String> urls;
  final List<String> names;
  final Map<String, String> headers;
  MangaHandoff._(this.urls, this.names, this.headers);
  factory MangaHandoff.prepare(DownloadTask task, List<ChapterPage> pages) {
    if (pages.isEmpty) throw StateError('Source returned no chapter pages.');
    final urls = <String>[], names = <String>[];
    Map<String, String>? common;
    final prefix =
        'SZ-${task.catalogKey.substring(0, task.catalogKey.length.clamp(0, 12))}';
    for (var i = 0; i < pages.length; i++) {
      final page = pages[i], uri = Uri.parse(pages[i].url.split('#').first);
      if (uri.scheme != 'http' && uri.scheme != 'https') {
        throw StateError(
          'This source cannot hand its pages to 1DM. Use the internal downloader.',
        );
      }
      final session = SessionManager();
      final cookies = session.getCookiesSync(uri.toString());
      final raw = <String, String>{
        'User-Agent':
            session.getUserAgentSync(uri.toString()) ??
            NetworkConfig.globalUserAgent,
        if (cookies.isNotEmpty) 'Cookie': cookies,
        ...NetworkConfig.globalHeaders,
        ...?page.headers,
        ...decodeUrlHeaders(page.url),
      };
      final headers = {
        for (final e in raw.entries) e.key.toLowerCase(): e.value,
      };
      if (common != null &&
          (headers.length != common.length ||
              headers.entries.any((e) => common![e.key] != e.value))) {
        throw StateError(
          'These pages require different request headers. Use the internal downloader for this source.',
        );
      }
      common = headers;
      urls.add(uri.toString());
      final ext =
          RegExp(
            r'\.(jpg|jpeg|png|gif|webp|avif)$',
            caseSensitive: false,
          ).firstMatch(uri.path)?.group(1)?.toLowerCase() ??
          'jpg';
      names.add('$prefix-${(i + 1).toString().padLeft(5, '0')}.$ext');
    }
    return MangaHandoff._(urls, names, common!);
  }
  String get pagesJson => jsonEncode(
    List.generate(urls.length, (i) => {'url': urls[i], 'headers': headers}),
  );
}
