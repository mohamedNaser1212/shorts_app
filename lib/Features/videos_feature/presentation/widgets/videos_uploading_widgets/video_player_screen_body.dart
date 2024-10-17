import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/play_icon_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/video_preview_slider_widget.dart';
import 'package:shorts/core/widgets/custom_app_bar.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreenBody extends StatefulWidget {
  const VideoPlayerScreenBody({
    super.key,
    required this.controller,
  });

  final VideoPlayerController controller;

  @override
  State<VideoPlayerScreenBody> createState() => VideoPlayerScreenBodyState();
}

class VideoPlayerScreenBodyState extends State<VideoPlayerScreenBody> {
  final ValueNotifier<Duration> positionNotifier = ValueNotifier(Duration.zero);
  final ValueNotifier<Duration> durationNotifier = ValueNotifier(Duration.zero);

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateState);
    durationNotifier.value = widget.controller.value.duration;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateState);
    positionNotifier.dispose();
    durationNotifier.dispose();
    super.dispose();
  }

  void _updateState() {
    positionNotifier.value = widget.controller.value.position;
    durationNotifier.value = widget.controller.value.duration;
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
              VideoPreviewSliderWidget(
                state: this,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

