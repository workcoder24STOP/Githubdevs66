import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shonenx/core/network/network_config.dart';
import 'package:shonenx/core/network/session_manager.dart';
import 'package:shonenx/core/utils/image_headers.dart';
import 'package:shonenx/features/reader/providers/reader_prefs_provider.dart';

/// Reader images always reserve visible space while decoding. In a vertical
/// list, a zero-height loading image can make the entire chapter appear blank.
class ReaderImage extends StatefulWidget {
  final String url;
  final Map<String, String>? headers;
  final int index;
  final ReaderScaleType scaleType;
  final Color textColor;
  final bool continuous;
  const ReaderImage({
    super.key,
    required this.url,
    required this.index,
    required this.scaleType,
    required this.textColor,
    this.headers,
    this.continuous = false,
  });
  @override
  State<ReaderImage> createState() => _ReaderImageState();
}

class _ReaderImageState extends State<ReaderImage> {
  int attempt = 0;
  ImageProvider? _provider;
  Future<void> retry() async {
    await _provider?.evict();
    if (mounted) setState(() => attempt++);
  }

  ImageProvider _imageProvider() {
    final raw = widget.url.trim();
    if (raw.startsWith('/') || raw.startsWith('file://')) {
      return FileImage(
        raw.startsWith('file://') ? File.fromUri(Uri.parse(raw)) : File(raw),
      );
    }
    if (raw.startsWith('http://') || raw.startsWith('https://')) {
      final url = raw.split('#').first;
      final session = SessionManager();
      final cookies = session.getCookiesSync(url);
      return CachedNetworkImageProvider(
        url,
        headers: {
          'User-Agent':
              session.getUserAgentSync(url) ?? NetworkConfig.globalUserAgent,
          if (cookies.isNotEmpty) 'Cookie': cookies,
          ...NetworkConfig.globalHeaders,
          ...?widget.headers,
          ...decodeUrlHeaders(raw),
        },
      );
    }
    return MemoryImage(
      base64Decode(raw.contains(',') ? raw.split(',').last : raw),
    );
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      final screen = MediaQuery.sizeOf(context);
      final width = box.hasBoundedWidth ? box.maxWidth : screen.width;
      final placeholderHeight = box.hasBoundedHeight
          ? box.maxHeight
          : screen.height * .75;
      Widget failure(Object error) => SizedBox(
        width: width,
        height: placeholderHeight,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.broken_image_outlined, size: 40),
              Text(
                'Could not load page ${widget.index + 1}',
                style: TextStyle(color: widget.textColor),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  widget.url.startsWith('/') || widget.url.startsWith('file:')
                      ? 'The saved image is missing or damaged. Download this chapter again.'
                      : 'Check your connection or retry this page.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: widget.textColor),
                ),
              ),
              TextButton.icon(
                onPressed: retry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry page'),
              ),
            ],
          ),
        ),
      );
      try {
        // Bound both dimensions, preserving aspect ratio. Very tall Webtoon
        // strips must not exceed the GPU texture/decoded-memory limits.
        final pixels = (width * MediaQuery.devicePixelRatioOf(context))
            .round()
            .clamp(1, 1600);
        _provider = ResizeImage(
          _imageProvider(),
          width: pixels,
          height: 8192,
          policy: ResizeImagePolicy.fit,
          allowUpscaling: false,
        );
        return Image(
          key: ValueKey('${widget.url}:$attempt'),
          image: _provider!,
          width: width,
          height: widget.continuous ? null : placeholderHeight,
          fit: widget.continuous
              ? BoxFit.fitWidth
              : switch (widget.scaleType) {
                  ReaderScaleType.fitHeight => BoxFit.fitHeight,
                  ReaderScaleType.fitWidth => BoxFit.contain,
                  ReaderScaleType.original => BoxFit.contain,
                },
          filterQuality: FilterQuality.medium,
          frameBuilder: (context, child, frame, synchronous) =>
              frame != null || synchronous
              ? child
              : SizedBox(
                  width: width,
                  height: placeholderHeight,
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
          errorBuilder: (context, error, stack) => failure(error),
        );
      } catch (error) {
        return failure(error);
      }
    },
  );
}
