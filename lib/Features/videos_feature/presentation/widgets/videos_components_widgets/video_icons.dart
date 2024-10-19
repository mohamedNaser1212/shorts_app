import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/widgets/comments_icon_widget.dart';
import 'package:shorts/core/widgets/favourite_icon_widget.dart';

class VideoIcons extends StatelessWidget {
  final VideoEntity videoEntity;

  const VideoIcons({
    super.key,
    required this.videoEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FavouriteIconWidget(videoEntity: videoEntity),
        const SizedBox(height: 10),
        CommentsIconWidget(videoEntity: videoEntity),
        const SizedBox(height: 10),
        IconButton(
          onPressed: _shareOnPressed,
          icon: const Icon(
            Icons.share,
            color: Colors.white,
            size: 35,
          ),
        ),
      ],
    );
  }

  void _shareOnPressed() {}
}
