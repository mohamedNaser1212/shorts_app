import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/preview_Screen_body.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/video_player_screen.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:video_player/video_player.dart';

class ThumbnailPreviewWidget extends StatelessWidget {
  const ThumbnailPreviewWidget({
    super.key,
    required this.controller,
    required this.widget,
  });

  final VideoPlayerController controller;
  final PreviewScreeBody widget;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: InkWell(
        onTap: () {
          if (widget.thumbnailFile != null) {
            NavigationManager.navigateTo(
              context: context,
              screen: VideoPlayerScreen(
                videoPath: widget.previewState.widget.outputPath,
              ),
            );
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.file(
              widget.thumbnailFile!,
              fit: BoxFit.cover,
              height: 320,
              width: 320,
            ),
            if (widget.thumbnailFile != null)
              const Icon(
                Icons.play_circle_fill,
                size: 60,
                color: Colors.white,
              ),
         
          ],
        ),
      ),
    );
  }
}
