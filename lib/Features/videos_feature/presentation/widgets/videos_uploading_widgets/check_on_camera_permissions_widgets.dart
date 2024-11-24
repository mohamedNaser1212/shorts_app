import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../../../core/video_controller/video_controller.dart';
import 'camera_permission_warning_widgets.dart';

class CheckOnCameraPermissionsWidgets extends StatelessWidget {
  const CheckOnCameraPermissionsWidgets({super.key, required this.notifier});
  final VideoController notifier;

  @override
  Widget build(BuildContext context) {
    if (notifier.isPermissionGranted &&
        notifier.cameraController != null &&
        notifier.cameraController!.value.isInitialized) {
      return CameraPreview(notifier.cameraController!);
    } else if (notifier.isPermissionPermanentlyDenied) {
      return const CameraPermissionWarningWidgets(
        title: " Camera Permission Denied Permanently",
      );
    } else if (notifier.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return SizedBox();
  }
}
