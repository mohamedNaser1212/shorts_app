import 'package:flutter/material.dart';
import 'package:shorts/core/video_controller/video_controller.dart';

import '../../../../../core/widgets/custom_icon_widget.dart';
import '../../video_cubit/upload_videos_cubit/upload_videos_cubit.dart';

class GallaryIconWidget extends StatelessWidget {
  const GallaryIconWidget({super.key, required this.notifier});
  final VideoController notifier;

  @override
  Widget build(BuildContext context) {
    // Only show gallery button if not recording, no video file, and permission is granted
    return Positioned(
      bottom: 16.0,
      right: 16.0,
      child: notifier.isRecording ||
              notifier.videoFile != null ||
              !notifier.isPermissionGranted
          ? const SizedBox() // Hide button if recording, video file exists, or permission is denied
          : IconButton(
              icon: const CustomIconWidget(
                icon: Icons.image,
                color: Colors.white,
              ),
              onPressed: () {
                UploadVideosCubit.get(context).pickVideo();
              },
            ),
    );
  }
}
