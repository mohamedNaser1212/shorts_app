import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/video_player_gesture.dart';
import 'package:video_player/video_player.dart';

class ThumbnailPage extends StatefulWidget {
  final String videoPath;

  const ThumbnailPage({super.key, required this.videoPath});

  @override
  State<ThumbnailPage> createState() => _ThumbnailPageState();
}

class _ThumbnailPageState extends State<ThumbnailPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
        _controller.play(); 
      });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Preview'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? VideoPlayerGesture(
                controller: _controller,
                togglePlayPause: togglePlayPause,
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}

