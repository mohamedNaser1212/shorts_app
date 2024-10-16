// video_icons.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/video_controller/video_controller.dart';
import 'package:shorts/core/notification_service/notification_helper.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import '../comments_widgets/comments_bottom_sheet.dart';

class VideoIcons extends StatelessWidget {
  final VideoController videoProvider;
  final VideoEntity? videoEntity;

  const VideoIcons({
    super.key,
    required this.videoProvider,
    this.videoEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<FavouritesCubit, FavouritesState>(
          listener: _toggleFavouriteListener,
          builder: (context, state) {
            final notificationHelper = GetIt.instance.get<NotificationHelper>();
            final isFavorite =
                FavouritesCubit.get(context).favorites[videoEntity!.id] ??
                    false;
            return IconButton(
              onPressed: () => _toggleFavourite(context, notificationHelper),
              icon: CircleAvatar(
                backgroundColor: isFavorite ? Colors.red : Colors.grey,
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        IconButton(
          onPressed: () => _commentsOnPressed(context: context),
          icon: const Icon(
            Icons.comment,
            color: Colors.white,
            size: 35,
          ),
        ),
        const SizedBox(height: 10),
        IconButton(
          onPressed: _shareOnPressed,
          icon: const Icon(
            Icons.share,
            color: Colors.white,
            size: 35,
          ),
        ),
      ],
    );
  }

  void _commentsOnPressed({
    required BuildContext context,
  }) {
    if (videoEntity != null) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => CommentsBottomSheet(videoEntity: videoEntity!),
      );
    }
  }

  void _toggleFavouriteListener(BuildContext context, FavouritesState state) {
    if (state is ToggleFavouriteSuccessState) {
      FavouritesCubit.get(context).getFavourites(
        user: UserInfoCubit.get(context).userEntity!,
      );
    }
  }

  void _shareOnPressed() {}
  void _toggleFavourite(
      BuildContext context, NotificationHelper notificationHelper) {
    
      final favouritesCubit = FavouritesCubit.get(context);
      final userEntity = UserInfoCubit.get(context).userEntity!;
      final isFavorite = favouritesCubit.favorites[videoEntity!.id] ?? false;
      favouritesCubit.favorites[videoEntity!.id] = !isFavorite;
      favouritesCubit.toggleFavourite(
        video: videoEntity!,
        userModel: userEntity,
      );

      notificationHelper.sendNotificationToSpecificUser(
        fcmToken: videoEntity!.user.fcmToken,
        userId: videoEntity!.user.id!,
        title: 'Like',
        body: 'Your video has been liked by ${userEntity.name}',
        context: context,
      );
    }
  }

