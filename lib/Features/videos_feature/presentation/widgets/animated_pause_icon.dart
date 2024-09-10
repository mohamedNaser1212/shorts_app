import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/video_notifiers/video_notifier.dart';

class AnimatedPauseIcon extends StatelessWidget {
  const AnimatedPauseIcon({
    super.key,
    required this.videoProvider,
  });

  final VideoProvider videoProvider;

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoProvider>(
      builder: (context, videoProvider, child) {
        return Center(
          child: AnimatedOpacity(
            opacity: videoProvider.showPlayPauseIcon ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Icon(
              videoProvider.controller?.value.isPlaying ?? false
                  ? Icons.pause
                  : Icons.play_arrow,
              color: Colors.white,
              size: 80,
            ),
          ),
        );
      },
    );
  }
}
