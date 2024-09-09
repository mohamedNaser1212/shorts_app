import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/domain/video_notifiers/video_notifier.dart';
import 'package:video_player/video_player.dart';

class AnimatedPauseIcon extends StatelessWidget {
  const AnimatedPauseIcon(
      {super.key, required this.videoUrl, required this.controller});
  final String videoUrl;
  final VideoPlayerController? controller;
  @override
  Widget build(BuildContext context) {
    final videoProvider = VideoProvider(videoUrl);

    return ValueListenableBuilder<bool>(
      valueListenable: videoProvider.showPlayPauseIconNotifier,
      builder: (context, showPlayPauseIcon, child) {
        return Center(
          child: AnimatedOpacity(
            opacity: showPlayPauseIcon ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Icon(
              controller?.value.isPlaying ?? false
                  ? Icons.pause
                  : Icons.play_arrow,
              color: Colors.white,
              size: 80,
            ),
          ),
        );
      },
    );
  }
}
