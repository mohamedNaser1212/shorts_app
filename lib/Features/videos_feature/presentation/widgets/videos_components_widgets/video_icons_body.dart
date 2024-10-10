

import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/video_notifiers/video_notifier.dart';

import 'video_icons.dart';

class PositionedVideoIcons extends StatelessWidget {
  final VideoController videoProvider;
  final VideoEntity? videoEntity;

  const PositionedVideoIcons({
    super.key,
    required this.videoProvider,
    this.videoEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 100,
      child: VideoIcons(
        videoProvider: videoProvider,
        videoEntity: videoEntity,
      ),
    );
  }
}
