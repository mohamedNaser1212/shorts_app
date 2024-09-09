import 'package:flutter/material.dart';

import '../../domain/video_notifiers/video_notifier.dart';

class LikeIcon extends StatelessWidget {
  const LikeIcon({super.key, required this.videoProvider});

  final VideoProvider videoProvider;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 100,
      child: Column(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: videoProvider.isLikedNotifier,
            builder: (context, isLiked, child) {
              return IconButton(
                onPressed: () {
                  videoProvider.toggleLike();
                },
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.white,
                  size: 40,
                ),
              );
            },
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
