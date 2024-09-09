import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../domain/video_notifiers/video_notifier.dart';

class VideoListItem extends StatelessWidget {
  final String videoUrl;

  const VideoListItem({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    final videoProvider = VideoProvider(videoUrl);

    return ValueListenableBuilder<VideoPlayerController?>(
      valueListenable: videoProvider.controllerNotifier,
      builder: (context, controller, child) {
        return GestureDetector(
          onTap: () => videoProvider.togglePlayPause(),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (controller?.value.isInitialized ?? false)
                VideoPlayer(controller!)
              else
                ValueListenableBuilder<Uint8List?>(
                  valueListenable: videoProvider.thumbnailNotifier,
                  builder: (context, thumbnailData, child) {
                    if (thumbnailData != null) {
                      return Image.memory(
                        thumbnailData,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ValueListenableBuilder<bool>(
                valueListenable: videoProvider.showPlayPauseIconNotifier,
                builder: (context, showPlayPauseIcon, child) {
                  return Center(
                    child: AnimatedOpacity(
                      opacity: showPlayPauseIcon ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        controller?.value.isPlaying ?? false
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 80,
                      ),
                    ),
                  );
                },
              ),
              Positioned(
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
              ),
              Positioned(
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
                                      videoProvider.seekTo(Duration(
                                          milliseconds: value.toInt()));
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          ValueListenableBuilder<Duration>(
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
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
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
