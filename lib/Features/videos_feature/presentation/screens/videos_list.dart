import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../domain/video_notifiers/video_notifier.dart';
import '../widgets/animated_pause_icon.dart';
import '../widgets/like_icon.dart';
import '../widgets/slider_notifier.dart';
import '../widgets/thumbnail_notifier.dart';

class VideoListItem extends StatelessWidget {
  final String videoUrl;

  const VideoListItem({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoProvider(videoUrl),
      child: Consumer<VideoProvider>(
        builder: (context, videoProvider, child) {
          return GestureDetector(
            onTap: () => videoProvider.togglePlayPause(),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (videoProvider.controller?.value.isInitialized ?? false)
                  VideoPlayer(videoProvider.controller!)
                else
                  ThumbnailNotifier(videoUrl: videoUrl),
                AnimatedPauseIcon(videoProvider: videoProvider),
                LikeIcon(videoProvider: videoProvider),
                SliderNotifier(videoProvider: videoProvider),
              ],
            ),
          );
        },
      ),
    );
  }
}
