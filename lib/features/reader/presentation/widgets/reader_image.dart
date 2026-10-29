import 'package:cached_network_image/cached_network_image.dart';
import 'package:shonenx/shared/widgets/smart_image.dart';
import 'package:flutter/material.dart';
import 'package:shonenx/features/reader/providers/reader_prefs_provider.dart';

class ReaderImage extends StatefulWidget {
  final String url;
  final Map<String, String>? headers;
  final int index;
  final ReaderScaleType scaleType;
  final Color textColor;

  const ReaderImage({
    super.key,
    required this.url,
    required this.index,
    required this.scaleType,
    required this.textColor,
    this.headers,
  });

  @override
  State<ReaderImage> createState() => _ReaderImageState();
}

class _ReaderImageState extends State<ReaderImage> {
  int attempt = 0;
  Future<void> retry() async {
    if (widget.url.startsWith('http')) {
      await CachedNetworkImage.evictFromCache(widget.url.split('#').first);
    }
    if (mounted) setState(() => attempt++);
  }

  @override
  Widget build(BuildContext context) {
    BoxFit fit = BoxFit.fitWidth;
    if (widget.scaleType == ReaderScaleType.fitHeight) {
      fit = BoxFit.fitHeight;
    } else if (widget.scaleType == ReaderScaleType.original) {
      fit = BoxFit.contain;
    }

    return SmartImage(
      key: ValueKey('${widget.url}:$attempt'),
      imageUrl: widget.url,
      httpHeaders: widget.headers,
      fit: fit,
      width: double.infinity,
      memCacheWidth: 1400,
      maxWidthDiskCache: 1800,
      progressIndicatorBuilder: (context, url, progress) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Center(
          child: CircularProgressIndicator(
            value: progress.progress,
            strokeWidth: 2,
          ),
        ),
      ),
      errorWidget: (context, url, error) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.broken_image, color: Colors.grey, size: 48),
            const SizedBox(height: 8),
            Text(
              'Failed to load page ${widget.index + 1}',
              style: TextStyle(color: widget.textColor.withValues(alpha: 0.5)),
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
  }
}
