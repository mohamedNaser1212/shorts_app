import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../domain/video_entity/video_entity.dart';
import '../../domain/video_notifiers/video_notifier.dart';
import '../widgets/animated_pause_icon.dart';
import '../widgets/like_icon.dart';
import '../widgets/slider_notifier.dart';
import '../widgets/thumbnail_notifier.dart';

class VideoListItem extends StatelessWidget {
  final VideoEntity videoEntity;
  final UserEntity userModel;

  const VideoListItem({
    super.key,
    required this.videoEntity,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoController(videoEntity.videoUrl),
      child: Consumer<VideoController>(
        builder: (context, videoProvider, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              GestureDetector(
                onTap: () => videoProvider.togglePlayPause(),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (videoProvider.controller?.value.isInitialized ?? false)
                      VideoPlayer(videoProvider.controller!)
                    else
                      ThumbnailNotifier(videoUrl: videoEntity.videoUrl),
                    AnimatedPauseIcon(videoProvider: videoProvider),
                    BlocConsumer<VideoCubit, VideoState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return BlocConsumer<FavouritesCubit, FavouritesState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return VideoIcons(
                              videoProvider: videoProvider,
                              videoEntity: videoEntity,
                              // favouritesEntity: ,
                            );
                          },
                        );
                      },
                    ),
                    SliderNotifier(videoProvider: videoProvider),
                  ],
                ),
              ),
              Positioned(
                bottom: 60,
                left: 10,
                child: Column(
                  children: [
                    Text(
                      videoEntity.user.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      videoEntity.description ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
