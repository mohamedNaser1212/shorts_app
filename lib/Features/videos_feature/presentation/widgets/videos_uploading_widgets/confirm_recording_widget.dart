import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/preview_screen.dart';
import 'package:shorts/core/video_controller/video_controller.dart';
import 'package:shorts/core/widgets/custom_icon_widget.dart';

class ConfirmRecordingWidget extends StatelessWidget {
  const ConfirmRecordingWidget({
    super.key,
    required this.videoFile,
    required this.videoController,
  });

  final XFile? videoFile;
  final VideoController? videoController;

  @override
  Widget build(BuildContext context) {
    if (videoFile != null) {
      return IconButton(
        icon: const CustomIconWidget(
          icon: Icons.check,
          color: Colors.white,
        ),
        onPressed: () => _confirmRecording(context: context),
      );
    }
    return const SizedBox();
  }

  void _confirmRecording({
    required BuildContext context,
  }) {
    if (videoFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewScreen(
            outputPath: videoFile!.path,
            thumbnailFile: videoController?.thumbnailFile,
          ),
        ),
      );
    }
  }
}
