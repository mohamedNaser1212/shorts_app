import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/confirm_recording_widget.dart';
import 'package:shorts/core/video_controller/video_controller.dart';

import '../../../../../core/widgets/custom_icon_widget.dart';
import '../../video_cubit/upload_videos_cubit/upload_videos_cubit.dart';

class GallaryIconWidget extends StatelessWidget {
  const GallaryIconWidget({super.key, required this.notifier});
  final VideoController notifier;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16.0,
      right: 16.0,
      child: notifier.isRecording
          ? const SizedBox() // Don't show anything when recording
          : notifier.videoFile != null
              ? ConfirmRecordingWidget(
                  videoFile: notifier.videoFile,
                  videoController: notifier,
                )
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
