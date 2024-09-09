import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoProvider with ChangeNotifier {
  VideoPlayerController? _controller;
  Uint8List? _thumbnailData;
  bool isLiked = false;
  bool _showPlayPauseIcon = false;

  VideoPlayerController? get controller => _controller;
  Uint8List? get thumbnailData => _thumbnailData;
  bool get showPlayPauseIcon => _showPlayPauseIcon;

  VideoProvider(String videoUrl) {
    _initializeController(videoUrl);
  }

  Future<void> _initializeController(String videoUrl) async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        notifyListeners();
      })
      ..setLooping(true)
      ..play();
    await _loadThumbnail(videoUrl);
  }

  Future<void> _loadThumbnail(String videoUrl) async {
    final thumbnailData = await VideoThumbnail.thumbnailData(
      video: videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      quality: 75,
    );

    _thumbnailData = thumbnailData;
    notifyListeners();
  }

  void togglePlayPause() {
    if (_controller!.value.isPlaying) {
      _controller!.pause();
    } else {
      _controller!.play();
    }
    _showPlayPauseIcon = true;
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), () {
      _showPlayPauseIcon = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
