import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/comments_icon_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/favourite_icon_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/share_icon_widget.dart';

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
         ShareIconWidget(
          videoEntity: videoEntity,
        ),
      ],
    );
  }
}
