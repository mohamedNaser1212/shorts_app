import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';

class VideoPreviewIconWidget extends StatelessWidget {
  final CachedVideoPlayerController controller;
  final VoidCallback togglePlayPause;

  const VideoPreviewIconWidget({
    super.key,
    required this.controller,
    required this.togglePlayPause,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: togglePlayPause,
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(
          children: [
            CachedVideoPlayer(controller),
            Positioned(
              bottom: 20,
              left: 20,
              child: FloatingActionButton(
                onPressed: togglePlayPause,
                child: Icon(
                  controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
