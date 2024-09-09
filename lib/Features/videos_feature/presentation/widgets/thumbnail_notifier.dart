import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../domain/video_notifiers/video_notifier.dart';

class ThumbnailNotifier extends StatelessWidget {
  const ThumbnailNotifier({super.key, required this.videoUrl});
  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    final videoProvider = VideoProvider(videoUrl);

    return ValueListenableBuilder<Uint8List?>(
      valueListenable: videoProvider.thumbnailNotifier,
      builder: (context, thumbnailData, child) {
        if (thumbnailData != null) {
          return Image.memory(
            thumbnailData,
            fit: BoxFit.cover,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
