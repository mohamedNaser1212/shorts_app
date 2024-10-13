import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_icons.dart';
import 'package:shorts/core/video_controller/video_controller.dart';

class VideoIconsSection extends StatelessWidget {
  const VideoIconsSection({
    super.key,
    required this.videoEntity,
    required this.videoProvider,
    
    
  });

  final VideoEntity videoEntity;
  final VideoController videoProvider;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.15,
      right: 10,
      child: VideoIcons(
        videoProvider:videoProvider,
        videoEntity: videoEntity,
      ),
    );
  }
}
