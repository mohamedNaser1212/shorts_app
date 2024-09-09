import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/slider_notifier.dart';
import 'package:video_player/video_player.dart';

import '../../domain/video_notifiers/video_notifier.dart';
import '../widgets/animated_pause_icon.dart';
import '../widgets/like_icon.dart';
import '../widgets/thumbnail_notifier.dart';

class VideoListItem extends StatefulWidget {
  final String videoUrl;

  const VideoListItem({super.key, required this.videoUrl});

  @override
  State<VideoListItem> createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  late final VideoProvider videoProvider;

  @override
  void initState() {
    super.initState();
    videoProvider = VideoProvider(widget.videoUrl);
  }

  @override
  void dispose() {
    videoProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<VideoPlayerController?>(
      valueListenable: videoProvider.controllerNotifier,
      builder: (context, controller, child) {
        return GestureDetector(
          onTap: () => videoProvider.togglePlayPause(),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (controller?.value.isInitialized ?? false)
                VideoPlayer(controller!)
              else
                ThumbnailNotifier(videoUrl: widget.videoUrl),
              AnimatedPauseIcon(
                  videoUrl: widget.videoUrl, controller: controller),
              LikeIcon(videoProvider: videoProvider),
              SliderNotifier(videoProvider: videoProvider),
            ],
          ),
        );
      },
    );
  }
}
