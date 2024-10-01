// positioned_video_icons.dart
import 'package:flutter/material.dart';

import 'package:shorts/Features/favourites_feature/domain/favourite_entitiy.dart';

import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/videos_feature/domain/video_notifiers/video_notifier.dart';

import 'video_icons.dart';

class PositionedVideoIcons extends StatelessWidget {
  final VideoController videoProvider;
  final VideoEntity? videoEntity;
  final FavouritesEntity favouriteEntity;

  const PositionedVideoIcons({
    super.key,
    required this.videoProvider,
    this.videoEntity,
    required this.favouriteEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 100,
      child: VideoIcons(
        videoProvider: videoProvider,
        videoEntity: videoEntity,
        favouriteEntity: favouriteEntity,
      ),
    );
  }
}
