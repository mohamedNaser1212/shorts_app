import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/video_player_screen_body.dart';
import 'package:shorts/core/widgets/duration_widget.dart';

class VideoPreviewDurationWidget extends StatelessWidget {
  const VideoPreviewDurationWidget({super.key, required this.state});
  final VideoPlayerScreenBodyState state;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DurationWidget(positionNotifier: state.positionNotifier),
        DurationWidget(positionNotifier: state.durationNotifier),
      ],
    );
  }
}
