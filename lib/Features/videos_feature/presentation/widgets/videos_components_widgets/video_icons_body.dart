import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'video_icons.dart';

class PositionedVideoIcons extends StatelessWidget {
  final VideoEntity videoEntity;

  const PositionedVideoIcons({
    super.key,
   required this.videoEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 100,
      child: VideoIcons(
        videoEntity: videoEntity,
      ),
    );
  }
}
