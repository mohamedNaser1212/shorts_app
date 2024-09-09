import 'package:flutter/material.dart';

import '../../domain/video_notifiers/video_notifier.dart';
import 'duration_notifier_widget.dart';

class SliderNotifier extends StatelessWidget {
  const SliderNotifier({super.key, required this.videoProvider});
  final VideoProvider videoProvider;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: ValueListenableBuilder<bool>(
        valueListenable: videoProvider.isPausedNotifier,
        builder: (context, isPaused, child) {
          return AnimatedOpacity(
            opacity: isPaused ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ValueListenableBuilder<Duration>(
                  valueListenable: videoProvider.positionNotifier,
                  builder: (context, position, child) {
                    return ValueListenableBuilder<Duration>(
                      valueListenable: videoProvider.durationNotifier,
                      builder: (context, duration, child) {
                        return Slider(
                          value: position.inMilliseconds.toDouble(),
                          min: 0.0,
                          max: duration.inMilliseconds.toDouble(),
                          onChanged: (value) {
                            videoProvider
                                .seekTo(Duration(milliseconds: value.toInt()));
                          },
                        );
                      },
                    );
                  },
                ),
                DurationNotifier(videoProvider: videoProvider),
              ],
            ),
          );
        },
      ),
    );
  }
}
