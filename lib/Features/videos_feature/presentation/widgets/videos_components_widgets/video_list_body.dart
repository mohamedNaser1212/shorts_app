import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/thumbnail_notifier.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_components_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_player_widget.dart';
import 'package:shorts/core/video_controller/video_controller.dart';

class VideoListBody extends StatefulWidget {
  const VideoListBody({
    super.key,
    required this.videoEntity,
    required this.videoController,
    required this.isShared,
  });

  final VideoEntity videoEntity;
  final VideoController videoController;
  final bool isShared;

  @override
  State<VideoListBody> createState() => _VideoListBodyState();
}

class _VideoListBodyState extends State<VideoListBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => widget.videoController.togglePlayPause(),
        child: Stack(
          children: [
            if (widget.videoController.controller?.value.isInitialized ?? false)
              VideoPlayerWidget(
                videoProvider: widget.videoController,
              )
            else
              ThumbnailNotifier(videoUrl: widget.videoEntity.videoUrl),
            if (!widget.isShared)
              VideoComponentsWidget(
                videoEntity: widget.videoEntity,
                videoProvider: widget.videoController,
                isShared: widget.isShared,
              ),
          ],
        ),
      ),
    );
  }
}
