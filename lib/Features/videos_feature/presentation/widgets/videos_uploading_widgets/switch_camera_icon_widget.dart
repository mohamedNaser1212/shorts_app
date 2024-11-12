import 'package:flutter/material.dart';

import '../../../../../core/video_controller/video_controller.dart';

class SwitchCameraIconWidget extends StatelessWidget {
  const SwitchCameraIconWidget({
    super.key,
    required this.notifier,
  });

  final VideoController notifier;

  @override
  Widget build(BuildContext context) {
    if (!notifier.isRecording) {
      return Positioned(
        bottom: 20,
        left: 20,
        child: IconButton(
          icon: const Icon(
            Icons.cameraswitch,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            if (notifier.cameraController != null &&
                notifier.cameraController!.value.isInitialized) {
              notifier.switchCamera();
            }
          },
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
