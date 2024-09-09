import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoListItem extends StatefulWidget {
  final String videoUrl;

  const VideoListItem({super.key, required this.videoUrl});

  @override
  _VideoListItemState createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  VideoPlayerController? _controller;
  Uint8List? _thumbnailData;
  bool isLiked = false;
  bool _showPlayPauseIcon = false;

  @override
  void initState() {
    super.initState();
    _loadThumbnail();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true)
      ..play();
  }

  Future<void> _loadThumbnail() async {
    final thumbnailData = await VideoThumbnail.thumbnailData(
      video: widget.videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      quality: 75,
    );

    setState(() {
      _thumbnailData = thumbnailData;
    });
  }

  void _togglePlayPause() {
    // Toggle play/pause on tap and show the icon
    if (_controller!.value.isPlaying) {
      _controller!.pause();
    } else {
      _controller!.play();
    }
    _showPlayPauseIcon = true;
    setState(() {});

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showPlayPauseIcon = false;
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlayPause,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (_controller?.value.isInitialized ?? false)
            VideoPlayer(_controller!)
          else if (_thumbnailData != null)
            Image.memory(
              _thumbnailData!,
              fit: BoxFit.cover,
            )
          else
            const Center(child: CircularProgressIndicator()),
          Center(
            child: AnimatedOpacity(
              opacity: _showPlayPauseIcon ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
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
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.white,
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
  }
}
