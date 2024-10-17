import 'package:flutter/material.dart';


import 'package:video_player/video_player.dart';


class VideoSlider extends StatelessWidget {
  const VideoSlider({
    super.key,
    required this.positionNotifier,
    required this.durationNotifier,
    required this.controller,
  });

  final ValueNotifier<Duration> positionNotifier;
  final ValueNotifier<Duration> durationNotifier;
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Duration>(
      valueListenable: positionNotifier,
      builder: (context, position, child) {
        return Slider(
          value: position.inSeconds.toDouble(),
          min: 0.0,
          max: durationNotifier.value.inSeconds.toDouble(),
          onChanged: (value) {
            controller.seekTo(Duration(seconds: value.toInt()));
          },
        );
      },
    );
  }
}
