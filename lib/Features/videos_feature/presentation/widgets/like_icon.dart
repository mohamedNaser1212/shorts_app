import 'package:flutter/material.dart';
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
  });

  final VideoController videoProvider;
  final VideoEntity videoEntity;

  @override
  State<LikeIcon> createState() => _LikeIconState();
}

class _LikeIconState extends State<LikeIcon> {
  late final VoidCallback _listener;
  final notificationHelper = GetIt.instance.get<NotificationHelper>();

  @override
  void initState() {
    super.initState();
    _listener = () {
      setState(() {});
    };
    widget.videoProvider.isLikedNotifier.addListener(_listener);
  }

  @override
  void dispose() {
    widget.videoProvider.isLikedNotifier.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLiked = widget.videoProvider.isLikedNotifier.value;

    return Positioned(
      right: 20,
      bottom: 100,
      child: Column(
        children: [
          IconButton(
            onPressed: () {
              widget.videoProvider.toggleLike();
              print(widget.videoEntity.user.fcmToken);
              FavouritesCubit.get(context)
                  .toggleFavourite(widget.videoEntity.id!);
              notificationHelper.sendNotificationToSpecificUser(
                fcmToken: widget.videoEntity.user.fcmToken,
                userId: widget.videoEntity.user.id!,
                title: 'Liked',
                body: 'Your video has been liked.',
                context: context,
              );
            },
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.red : Colors.white,
              size: 40,
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
  }
}