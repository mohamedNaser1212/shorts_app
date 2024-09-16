import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';

import '../../../../core/notification_service/notification_helper.dart';
import '../../domain/video_notifiers/video_notifier.dart';

class LikeIcon extends StatefulWidget {
  const LikeIcon({
    super.key,
    required this.videoProvider,
    required this.videoEntity,
/*    required this.favouritesEntity,*/
  });

  final VideoController videoProvider;
  final VideoEntity videoEntity;
  //final FavouritesEntity favouritesEntity;

  @override
  State<LikeIcon> createState() => _LikeIconState();
}

class _LikeIconState extends State<LikeIcon> {
  @override
  initState() {
    super.initState();
    FavouritesCubit.get(context).getFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouritesCubit, FavouritesState>(
      builder: (context, state) {
        final notificationHelper = GetIt.instance.get<NotificationHelper>();
        final isFavorite =
            FavouritesCubit.get(context).favorites[widget.videoEntity.id] ??
                false;

        return Positioned(
          right: 20,
          bottom: 100,
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  FavouritesCubit.get(context)
                      .toggleFavourite(widget.videoEntity.id);

                  notificationHelper.sendNotificationToSpecificUser(
                    fcmToken: widget.videoEntity.user.fcmToken,
                    userId: widget.videoEntity.user.id!,
                    title: 'Liked',
                    body: 'Your video has been liked.',
                    context: context,
                  );

                  print('videoEntity.id: ${widget.videoEntity.id}');
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
                onPressed: () {},
                icon: const Icon(
                  Icons.comment,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              const SizedBox(height: 10),
              IconButton(
                onPressed: () {},
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
