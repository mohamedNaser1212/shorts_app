import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../domain/video_notifiers/video_notifier.dart';

class VideoListItem extends StatelessWidget {
  final String videoUrl;

  const VideoListItem({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoProvider(videoUrl),
      child: Consumer<VideoProvider>(
        builder: (context, videoProvider, child) {
          return GestureDetector(
            onTap: () => videoProvider.togglePlayPause(),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (videoProvider.controller?.value.isInitialized ?? false)
                  VideoPlayer(videoProvider.controller!)
                else if (videoProvider.thumbnailData != null)
                  Image.memory(
                    videoProvider.thumbnailData!,
                    fit: BoxFit.cover,
                  )
                else
                  const Center(child: CircularProgressIndicator()),
                Center(
                  child: AnimatedOpacity(
                    opacity: videoProvider.showPlayPauseIcon ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      videoProvider.controller!.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 100,
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          videoProvider.isLiked = !videoProvider.isLiked;
                          videoProvider.notifyListeners();
                        },
                        icon: Icon(
                          videoProvider.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              videoProvider.isLiked ? Colors.red : Colors.white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 10),
                      IconButton(
                        onPressed: () {
                          // Add comment functionality here
                        },
                        icon: const Icon(
                          Icons.comment,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      const SizedBox(height: 10),
                      IconButton(
                        onPressed: () {
                          // Add share functionality here
                        },
                        icon: const Icon(
                          Icons.share,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
