import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_icon_widget.dart';
import '../../video_cubit/upload_videos_cubit/upload_videos_cubit.dart';

class GallaryIconWidget extends StatelessWidget {
  const GallaryIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return // Gallery icon at the bottom right
        Positioned(
      bottom: 16.0,
      right: 16.0,
      child: IconButton(
        icon: const CustomIconWidget(
          icon: Icons.video_library,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          UploadVideosCubit.get(context).pickVideo();
        },
      ),
    );
  }
}
