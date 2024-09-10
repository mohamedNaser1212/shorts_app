import 'package:flutter/material.dart';

import '../../domain/video_notifiers/video_notifier.dart';

class LikeIcon extends StatefulWidget {
  const LikeIcon({super.key, required this.videoProvider});

  final VideoProvider videoProvider;

  @override
  State<LikeIcon> createState() => _LikeIconState();
}

class _LikeIconState extends State<LikeIcon> {
  late final VoidCallback _listener;

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
