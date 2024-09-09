import 'package:flutter/material.dart';

import '../../domain/video_notifiers/video_notifier.dart';

class DurationNotifier extends StatelessWidget {
  const DurationNotifier({super.key, required this.videoProvider});
  final VideoProvider videoProvider;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Duration>(
      valueListenable: videoProvider.positionNotifier,
      builder: (context, position, child) {
        return ValueListenableBuilder<Duration>(
          valueListenable: videoProvider.durationNotifier,
          builder: (context, duration, child) {
            return Text(
              '${_formatDuration(position)} / ${_formatDuration(duration)}',
              style: const TextStyle(color: Colors.white),
            );
          },
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
