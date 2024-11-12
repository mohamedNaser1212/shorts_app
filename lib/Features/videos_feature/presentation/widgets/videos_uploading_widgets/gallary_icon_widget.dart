import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/video_recording_icon_widget.dart';

import '../../../../../core/video_controller/video_controller.dart';
import '../../video_cubit/upload_videos_cubit/upload_videos_cubit.dart';

class GallaryIconWidget extends StatelessWidget {
  const GallaryIconWidget({
    super.key,
    required this.notifier,
  });

  final VideoController notifier;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16.0,
      left: 16.0,
      right: 16.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon:
                const Icon(Icons.video_library, color: Colors.white, size: 30),
            onPressed: () {
              UploadVideosCubit.get(context).pickVideo();
            },
          ),
          VideoRecordingIcon(
            notifier: notifier,
          ),
        ],
      ),
    );
  }
}
