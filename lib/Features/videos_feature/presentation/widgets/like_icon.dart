import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shorts/Features/favourites_feature/domain/favourite_entitiy.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/notification_service/notification_helper.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';

import '../../../comments_feature/presentation/cubit/comments_cubit.dart';
import '../../domain/video_notifiers/video_notifier.dart';
import 'comments_bottom_sheet.dart';

class VideoIcons extends StatefulWidget {
  final VideoController videoProvider;
  VideoEntity? videoEntity;
  final FavouritesEntity favouriteEntity;

  VideoIcons({
    super.key,
    required this.videoProvider,
    this.videoEntity,
    required this.favouriteEntity,
  });

  @override
  State<VideoIcons> createState() => _VideoIconsState();
}

class _VideoIconsState extends State<VideoIcons> {
  @override
  void initState() {
    super.initState();
    final userEntity = UserInfoCubit.get(context).userEntity;
    if (widget.videoEntity != null && userEntity != null) {
      FavouritesCubit.get(context).getFavourites(user: userEntity);
      CommentsCubit.get(context)
          .startListeningToComments(widget.videoEntity!.id);
    }
  }

  void _showCommentBottomSheet() {
    if (widget.videoEntity != null) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) =>
            CommentsBottomSheet(videoEntity: widget.videoEntity!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouritesCubit, FavouritesState>(
      builder: (context, state) {
        final notificationHelper = GetIt.instance.get<NotificationHelper>();
        final isFavorite =
            FavouritesCubit.get(context).favorites[widget.videoEntity?.id] ??
                false;

        return Positioned(
          right: 20,
          bottom: 100,
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  if (widget.videoEntity != null) {
                    FavouritesCubit.get(context).toggleFavourite(
                      videoEntity: widget.favouriteEntity!,
                      userModel: UserInfoCubit.get(context).userEntity!,
                    );

                    notificationHelper.sendNotificationToSpecificUser(
                      fcmToken: widget.videoEntity!.user.fcmToken,
                      userId: widget.videoEntity!.user.id!,
                      title: 'Like',
                      body:
                          'Your video has been liked by ${UserInfoCubit.get(context).userEntity!.name}',
                      context: context,
                    );
                  }
                },
                icon: CircleAvatar(
                  backgroundColor: isFavorite ? Colors.red : Colors.grey,
                  radius: 15,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              IconButton(
                onPressed: _showCommentBottomSheet,
                icon: const Icon(
                  Icons.comment,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              const SizedBox(height: 10),
              IconButton(
                onPressed: () {
                  // Share functionality can be implemented here
                },
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
