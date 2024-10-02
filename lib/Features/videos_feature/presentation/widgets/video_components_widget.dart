import 'package:flutter/material.dart';
import 'package:shorts/Features/favourites_feature/domain/favourite_entitiy.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/animated_pause_icon.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/slider_notifier.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/video_icons_screen.dart';
import 'package:shorts/core/video_notifiers/video_notifier.dart';

class VideoComponentsWidget extends StatelessWidget {
  const VideoComponentsWidget({
    super.key,
    required this.videoEntity,
    required this.favouriteEntity,
    required this.videoProvider,
  });

  final VideoEntity videoEntity;
  final FavouritesEntity favouriteEntity;
  final VideoController videoProvider;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          AnimatedPauseIcon(videoProvider: videoProvider),
          VideoIconsScreen(
            videoEntity: videoEntity,
            favouriteEntity: favouriteEntity,
            videoProvider: videoProvider,
          ),
          SliderNotifier(videoProvider: videoProvider),
        ],
      ),
    );
  }
}
