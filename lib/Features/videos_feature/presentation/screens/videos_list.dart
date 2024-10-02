import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shorts/Features/favourites_feature/domain/favourite_entitiy.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/video_icons_screen.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../domain/video_entity/video_entity.dart';
import '../../../../core/video_notifiers/video_notifier.dart';
import '../widgets/animated_pause_icon.dart';
import '../widgets/slider_notifier.dart';
import '../widgets/thumbnail_notifier.dart';

class VideoListItem extends StatelessWidget {
  final VideoEntity videoEntity;
  final UserEntity userModel;
  final FavouritesEntity favouriteEntity;

  const VideoListItem({
    super.key,
    required this.videoEntity,
    required this.userModel,
    required this.favouriteEntity,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoController(videoEntity.videoUrl),
      child: Consumer<VideoController>(
        builder: (context, videoProvider, child) {
          return GestureDetector(
            onTap: () => videoProvider.togglePlayPause(),
            child: Stack(
              children: [
                if (videoProvider.controller?.value.isInitialized ?? false)
                  SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: SizedBox(
                        width: videoProvider.controller!.value.size.width,
                        height:
                            videoProvider.controller!.value.size.height * 2.9,
                        child: VideoPlayer(videoProvider.controller!),
                      ),
                    ),
                  )
                else
                  ThumbnailNotifier(videoUrl: videoEntity.videoUrl),
                // Video controls and overlays
                Positioned.fill(
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
