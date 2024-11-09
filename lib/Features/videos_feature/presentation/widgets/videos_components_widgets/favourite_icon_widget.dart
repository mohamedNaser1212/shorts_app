import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/get_favourites_cubit/favourites_cubit.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/toggle_favourites_cubit/toggle_favourites_cubit_cubit.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/functions/toast_function.dart';
import 'package:shorts/core/notification_service/notification_helper.dart';
import 'package:shorts/core/service_locator/service_locator.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/widgets/custom_icon_widget.dart';

class FavouriteIconWidget extends StatelessWidget {
  const FavouriteIconWidget({super.key, required this.videoEntity});
  final VideoEntity videoEntity;

  @override
  Widget build(BuildContext context) {
    final favouritesCubit = FavouritesCubit.get(context);
    return BlocConsumer<ToggleFavouritesCubit, ToggleFavouritesState>(
      listener: _toggleFavouriteListener,
      builder: (context, state) {
        final notificationHelper = getIt.get<NotificationHelper>();
        final isFavorite = favouritesCubit.favorites[videoEntity.id] ?? false;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => _toggleFavourite(context, notificationHelper),
              icon: CustomIconWidget(
                icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.white,
              ),
            ),
            StreamBuilder<Map<String, num>>(
              stream: favouritesCubit.favouritesCountStream,
              builder: (context, snapshot) {
                final count = snapshot.data?[videoEntity.id] ?? 0;
                return Text(
                  count.toString(),
                  style: const TextStyle(color: Colors.white),
                );
              },
            ),
          ],
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

    if (state is ToggleFavoriteErrorState) {
      ToastHelper.showToast(message: state.message);
      final favouritesCubit = FavouritesCubit.get(context);

      var isFavorite = favouritesCubit.favorites[videoEntity.id] ?? false;
      final previousCount =
          favouritesCubit.favouritesCount[videoEntity.id] ?? 0;

      favouritesCubit.favorites[videoEntity.id] = !isFavorite;

      final newCount = isFavorite ? previousCount - 1 : previousCount + 1;
      favouritesCubit.favouritesCount[videoEntity.id] = newCount;
    }
  }

  void _toggleFavourite(
    BuildContext context,
    NotificationHelper notificationHelper,
  ) {
    final favouritesCubit = FavouritesCubit.get(context);
    final userEntity = UserInfoCubit.get(context).userEntity!;
    final isFavorite = favouritesCubit.favorites[videoEntity.id] ?? false;
    final previousCount = favouritesCubit.favouritesCount[videoEntity.id] ?? 0;
    favouritesCubit.favorites[videoEntity.id] = !isFavorite;
    final newCount = isFavorite ? previousCount - 1 : previousCount + 1;
    favouritesCubit.favouritesCount[videoEntity.id] = newCount;
    favouritesCubit.updateFavouriteCount();
    ToggleFavouritesCubit.get(context).toggleFavourite(
      video: videoEntity,
      userModel: userEntity,
    );

    // Optionally, send a notification
    // notificationHelper.sendNotificationToSpecificUser(
    //   fcmToken: videoEntity.user.fcmToken,
    //   userId: videoEntity.user.id!,
    //   title: 'Like',
    //   body: 'Your video has been liked by ${userEntity.name}',
    //   context: context,
    // );
  }
}
