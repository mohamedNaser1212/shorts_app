import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/comments_cubit.dart';
import 'package:shorts/Features/favourites_feature/domain/favourite_entitiy.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/video_icons.dart';
import 'package:shorts/core/video_notifiers/video_notifier.dart';
import 'package:shorts/core/widgets/custom_list_tile.dart';

class VideoIconsScreen extends StatelessWidget {
  const VideoIconsScreen({
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
    return BlocConsumer<CommentsCubit, CommentsState>(
      listener: _commentsListener,
      builder: _builder,
    );
  }

  Widget _builder(context, state) {
      return BlocConsumer<VideoCubit, VideoState>(
        listener: _videoListener,
        builder: _videoCubitBuilder,
      );
    }

  void _videoListener(context, state) {}

  Widget _videoCubitBuilder(context, state) {
      return BlocConsumer<FavouritesCubit, FavouritesState>(
        listener: _favouritesListener,
        builder: _favouriteCubitBuilder,
      );
    }

  void _favouritesListener(context, state) {}

  Widget _favouriteCubitBuilder(context, state) {
      return Stack(
        children: [
          Positioned(
            bottom: 60,
            right: MediaQuery.of(context).size.width * 0.15,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.12,
              child: CustomListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 20,
                ),
                title: videoEntity.user.name,
                subtitle: videoEntity.description ?? '',
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            right: 10,
            child: VideoIcons(
              videoProvider: videoProvider,
              videoEntity: videoEntity,
              favouriteEntity: favouriteEntity,
            ),
          ),
        ],
      );
    }

  void _commentsListener(context, state) {
    }
}
