import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_action_buttons_body.dart';

class VideoActionIcons extends StatelessWidget {
  const VideoActionIcons({
    super.key,
    required this.videoEntity,
  });

  final VideoEntity videoEntity;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.15,
      right: 10,
      child: VideoIcons(
        videoEntity: videoEntity,
      ),
    );
  }
}
