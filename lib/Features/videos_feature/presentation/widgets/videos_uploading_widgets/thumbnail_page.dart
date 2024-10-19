import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_preview_icon_widget.dart';
import 'package:provider/provider.dart';
import 'package:shorts/core/video_controller/video_controller.dart';
import 'package:shorts/core/widgets/custom_app_bar.dart';

class ThumbnailPage extends StatelessWidget {
  final String videoPath;

  const ThumbnailPage({super.key, required this.videoPath});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoController(videoPath),
      child: Consumer<VideoController>(
        builder: (context, videoController, child) {
          final controller = videoController.controller;

          return Scaffold(
            appBar: const CustomAppBar(title: 'Video Preview'),
            body: Center(
              child: controller != null && controller.value.isInitialized
                  ? VideoPreviewIconWidget(
                      controller: controller,
                      togglePlayPause: videoController.togglePlayPause,
                    )
                  : const CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
