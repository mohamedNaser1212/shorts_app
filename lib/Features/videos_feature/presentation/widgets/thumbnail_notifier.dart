import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/video_notifiers/video_notifier.dart';

class ThumbnailNotifier extends StatelessWidget {
  const ThumbnailNotifier({super.key, required this.videoUrl});
  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoProvider>(
      builder: (context, videoProvider, child) {
        final thumbnailData = videoProvider.thumbnail;
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
