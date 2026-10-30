import 'dart:convert';
import 'package:shonenx/features/downloads/domain/models/download_task.dart';
import 'package:shonenx/shared/models/unified_episode.dart';
import 'package:shonenx/shared/models/unified_media.dart';
import 'package:shonenx/source_engine/models/source_info.dart';

sealed class ReaderMode {
  const ReaderMode();
  UnifiedMedia get media;
  UnifiedEpisode get episode;
  SourceInfo get sourceInfo;
  int get startPosition;
}

class ReaderModeOnline extends ReaderMode {
  @override
  final UnifiedMedia media;
  @override
  final UnifiedEpisode episode; // This represents the chapter
  @override
  final SourceInfo sourceInfo;
  @override
  final int startPosition;

  const ReaderModeOnline({
    required this.media,
    required this.episode,
    required this.sourceInfo,
    this.startPosition = 1,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReaderModeOnline &&
          runtimeType == other.runtimeType &&
          media.id == other.media.id &&
          episode.id == other.episode.id &&
          sourceInfo.id == other.sourceInfo.id &&
          startPosition == other.startPosition;

  @override
  int get hashCode =>
      media.id.hashCode ^
      episode.id.hashCode ^
      sourceInfo.id.hashCode ^
      startPosition.hashCode;
}

/// The standard reader with an explicit local download; never resolves a source.
class ReaderModeOffline extends ReaderMode {
  final DownloadTask task;
  @override
  final int startPosition;
  ReaderModeOffline({required this.task, int? startPosition})
    : startPosition = startPosition ?? task.readingPage + 1;

  @override
  UnifiedMedia get media {
    MediaExternalIds ids = const MediaExternalIds();
    try {
      ids = MediaExternalIds.fromMap(
        (jsonDecode(task.externalIdsJson) as Map).cast<String, dynamic>(),
      );
    } catch (_) {}
    return UnifiedMedia(
      id: task.mediaId,
      type: MediaType.MANGA,
      title: MediaTitle(english: task.mediaTitle),
      sourceId: task.sourceId,
      sourceName: task.sourceName,
      externalIds: ids,
    );
  }

  @override
  UnifiedEpisode get episode => UnifiedEpisode(
    id: task.itemId.isEmpty ? task.catalogKey : task.itemId,
    number: task.episodeNumber,
    season: task.season,
    title: task.itemTitle,
    scanlator: task.scanlator,
  );
  @override
  SourceInfo get sourceInfo => SourceInfo(
    id: task.sourceId,
    name: task.sourceName,
    type: SourceType.extension,
    mediaType: MediaType.MANGA,
    baseUrl: task.sourceBaseUrl,
  );
  @override
  bool operator ==(Object other) =>
      other is ReaderModeOffline &&
      task.id == other.task.id &&
      task.catalogKey == other.task.catalogKey &&
      startPosition == other.startPosition;
  @override
  int get hashCode => Object.hash(task.id, task.catalogKey, startPosition);
}
