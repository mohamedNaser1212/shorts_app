import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/play_icon_widget.dart';
import 'package:shorts/core/widgets/custom_app_bar.dart';
import 'package:shorts/core/widgets/duration_display_widget.dart';
import 'package:shorts/core/widgets/video_slider_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreenBody extends StatefulWidget {
  const VideoPlayerScreenBody({
    super.key,
    required this.controller,
  });

  final VideoPlayerController controller;

  @override
  State<VideoPlayerScreenBody> createState() => _VideoPlayerScreenBodyState();
}

class _VideoPlayerScreenBodyState extends State<VideoPlayerScreenBody> {
  final ValueNotifier<Duration> _positionNotifier = ValueNotifier(Duration.zero);
  final ValueNotifier<Duration> _durationNotifier = ValueNotifier(Duration.zero);

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateState);
    _durationNotifier.value = widget.controller.value.duration;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateState);
    _positionNotifier.dispose();
    _durationNotifier.dispose();
    super.dispose();
  }

  void _updateState() {
    _positionNotifier.value = widget.controller.value.position;
    _durationNotifier.value = widget.controller.value.duration;
  }

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
              VideoPlayer(widget.controller),
              PlayIcon(
                videoPlayerScreenState: widget.controller,
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DurationDisplay(positionNotifier: _positionNotifier),
                        DurationDisplay(positionNotifier: _durationNotifier),
                      ],
                    ),
                    VideoSlider(
                      positionNotifier: _positionNotifier,
                      durationNotifier: _durationNotifier,
                      controller: widget.controller,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



