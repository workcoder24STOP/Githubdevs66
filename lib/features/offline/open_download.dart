import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shonenx/core/router/app_navigator.dart';
import 'package:shonenx/features/downloads/domain/models/download_task.dart';
import 'package:shonenx/features/offline/offline_reader.dart';
import 'package:shonenx/features/player/domain/player_mode.dart';
import 'package:shonenx/shared/models/video_stream.dart';

Future<void> openDownload(BuildContext context, DownloadTask task) async {
  try {
    if (task.status != DownloadStatus.completed) return;
    if (task.isManga) {
      await Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(builder: (_) => OfflineReader(task: task)),
      );
    } else {
      if (!await File(task.savePath).exists()) {
        throw StateError(
          'Video was moved or deleted. Import or download it again.',
        );
      }
      if (!context.mounted) return;
      context.pushPlayer(
        PlayerModeOffline(
          filePath: task.savePath,
          title: '${task.mediaTitle} — S${task.season} · ${task.episodeNumber}',
          taskId: task.id,
          startPosition: Duration(milliseconds: task.playbackMs),
          subtitles: task.subtitles
              .where((s) => File(s.url).existsSync())
              .map(
                (s) => SubtitleTrack(
                  url: s.url,
                  language: s.language,
                  label: s.label,
                ),
              )
              .toList(),
        ),
      );
    }
  } catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$error')));
    }
  }
}
