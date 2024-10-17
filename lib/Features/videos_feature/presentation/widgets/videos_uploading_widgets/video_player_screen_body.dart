import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/play_icon_widget.dart';
import 'package:shorts/core/widgets/custom_app_bar.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreenBody extends StatelessWidget {
  const VideoPlayerScreenBody({
    super.key,
    required this.controller,
  });

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Video Player'),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            alignment: Alignment.center,
            children: [
              VideoPlayer(controller),
              PlayIcon(
                videoPlayerScreenState: controller,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
