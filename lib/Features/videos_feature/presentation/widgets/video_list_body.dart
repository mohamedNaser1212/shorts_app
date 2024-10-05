import 'package:flutter/material.dart';
import 'package:shorts/Features/favourites_feature/domain/favourite_entitiy.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/thumbnail_notifier.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/video_components_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/video_player_widget.dart';
import 'package:shorts/core/video_notifiers/video_notifier.dart';

class VideoListBody extends StatelessWidget {
  const VideoListBody({
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => videoProvider.togglePlayPause(),
        child: Stack(
          children: [
            if (videoProvider.controller?.value.isInitialized ?? false)
              VideoPlayerWidget(
                videoProvider: videoProvider,
              )
            else
              ThumbnailNotifier(videoUrl: videoEntity.videoUrl),
            VideoComponentsWidget(
              videoEntity: videoEntity,
              favouriteEntity: favouriteEntity,
              videoProvider: videoProvider,
            ),
          ],
        ),
      ),
    );
  }
}
