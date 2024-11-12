import 'package:flutter/material.dart';
import 'package:shorts/core/video_controller/video_controller.dart';
import 'package:shorts/core/widgets/custom_icon_widget.dart';

class SwitchCameraIconWidget extends StatelessWidget {
  const SwitchCameraIconWidget({super.key, required this.notifier});
  final VideoController notifier;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20.0,
      left: 16.0,
      child: notifier.isRecording
          ? const SizedBox()
          : notifier.videoFile != null
              ? const SizedBox()
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
