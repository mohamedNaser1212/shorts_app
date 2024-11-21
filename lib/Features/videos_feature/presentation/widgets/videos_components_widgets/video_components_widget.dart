import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/animated_pause_icon.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/slider_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_contents_screen.dart';
import 'package:shorts/core/video_controller/video_controller.dart';

class VideoComponentsWidget extends StatefulWidget {
  const VideoComponentsWidget({
    super.key,
    required this.videoEntity,
    required this.videoProvider,
    // required this.isShared,
  });

  final VideoEntity videoEntity;
  final VideoController videoProvider;

  @override
  State<VideoComponentsWidget> createState() => VideoComponentsWidgetState();
}

class VideoComponentsWidgetState extends State<VideoComponentsWidget> {
  // final bool isShared;
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          AnimatedPauseIcon(videoController: widget.videoProvider),
          VideoContentsScreen(
            videoEntity: widget.videoEntity,
            videoComponentsWidgetState: this,
            // isShared: isShared,
          ),
          SliderWidget(videoProvider: widget.videoProvider),
        ],
      ),
    );
  }
}
