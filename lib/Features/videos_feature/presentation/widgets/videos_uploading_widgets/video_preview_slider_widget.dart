import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/video_player_screen_body.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/video_preview_duration_widget.dart';
import 'package:shorts/core/widgets/video_slider_widget.dart';

class VideoSliderWidget extends StatelessWidget {
  const VideoSliderWidget({
    super.key,
    required this.state,
  });
  final VideoPlayerScreenBodyState state;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Column(
        children: [
          VideoPreviewDurationWidget(
            state: state,
          ),
          VideoSlider(
            positionNotifier: state.positionNotifier,
            durationNotifier: state.durationNotifier,
            controller: state.widget.controller,
          ),
        ],
      ),
    );
  }
}
