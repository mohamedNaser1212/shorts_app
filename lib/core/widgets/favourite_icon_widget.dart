import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/get_favourites_cubit/favourites_cubit.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/toggle_favourites_cubit/toggle_favourites_cubit_cubit.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/notification_service/notification_helper.dart';
import 'package:shorts/core/service_locator/service_locator.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';

class FavouriteIconWidget extends StatelessWidget {
  const FavouriteIconWidget({super.key, required this.videoEntity});
  final VideoEntity videoEntity;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToggleFavouritesCubit, ToggleFavouritesState>(
      listener: _toggleFavouriteListener,
      builder: (context, state) {
        final notificationHelper = getIt.get<NotificationHelper>();
        final isFavorite =
            FavouritesCubit.get(context).favorites[videoEntity.id] ?? false;
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
    );
  }

  void _toggleFavouriteListener(
      BuildContext context, ToggleFavouritesState state) {
    if (state is ToggleFavouriteSuccessState) {
      FavouritesCubit.get(context).getFavourites(
        user: UserInfoCubit.get(context).userEntity!,
      );
    }
  }

  void _toggleFavourite(
      BuildContext context, NotificationHelper notificationHelper) {
    final favouritesCubit = FavouritesCubit.get(context);
    final userEntity = UserInfoCubit.get(context).userEntity!;
    final isFavorite = favouritesCubit.favorites[videoEntity.id] ?? false;
    favouritesCubit.favorites[videoEntity.id] = !isFavorite;
    ToggleFavouritesCubit.get(context).toggleFavourite(
      video: videoEntity,
      userModel: userEntity,
    );

    notificationHelper.sendNotificationToSpecificUser(
      fcmToken: videoEntity.user.fcmToken,
      userId: videoEntity.user.id!,
      title: 'Like',
      body: 'Your video has been liked by ${userEntity.name}',
      context: context,
    );
  }
}
