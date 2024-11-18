import 'package:flutter/material.dart';
import 'package:shorts/core/video_controller/video_controller.dart';
import 'package:shorts/core/widgets/custom_icon_widget.dart';

class SwitchCameraIconWidget extends StatelessWidget {
  const SwitchCameraIconWidget({super.key, required this.notifier});
  final VideoController notifier;

  @override
  Widget build(BuildContext context) {
    // Only show switch camera button if the user is not recording, and permission is granted
    return Positioned(
      bottom: 20.0,
      left: 16.0,
      child: notifier.isRecording ||
              notifier.videoFile != null ||
              !notifier.isPermissionGranted
          ? const SizedBox() // Hide button if recording or permission is denied
          : IconButton(
              icon: const CustomIconWidget(
                icon: Icons.switch_camera_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                notifier.switchCamera();
              },
            ),
    );
  }
}
