import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_icon_widget.dart';
import 'package:shorts/core/widgets/custom_title.dart';

class ShareIconWidget extends StatelessWidget {
  const ShareIconWidget({super.key, required this.videoEntity});
  final VideoEntity videoEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () => _shareVideo(context),
          icon: const CustomIconWidget(
            icon: Icons.share,
            color: ColorController.whiteColor,
            size: 35,
          ),
        ),
        const SizedBox(height: 5),
        const CustomTitle(
          title: 'Share',
          style: TitleStyle.style16Bold,
          color: ColorController.whiteColor,
        ),
      ],
    );
  }

  void _shareVideo(BuildContext context) async {
    try {
      await Share.share(
        videoEntity.videoUrl,
        subject: 'Check out this video!',
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error sharing the video')),
      );
    }
  }
}
