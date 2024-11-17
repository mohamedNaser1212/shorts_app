import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/preview_screen.dart';
import 'package:shorts/core/video_controller/video_controller.dart';
import 'package:shorts/core/widgets/custom_icon_widget.dart';

class ConfirmRecordingWidget extends StatefulWidget {
  ConfirmRecordingWidget({
    super.key,
    required this.videoFile,
    required this.videoController,
  });

  late XFile? videoFile;
  final VideoController? videoController;

  @override
  State<ConfirmRecordingWidget> createState() => _ConfirmRecordingWidgetState();
}

class _ConfirmRecordingWidgetState extends State<ConfirmRecordingWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.videoFile != null) {
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
    if (widget.videoFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewScreen(
            outputPath: widget.videoFile!.path,
            thumbnailFile: widget.videoController?.thumbnailFile,
          ),
        ),
      ).then((_) {
        // Reset the video file after confirmation
        widget.videoController?.resetVideoFile();
      });
    }
  }
}
