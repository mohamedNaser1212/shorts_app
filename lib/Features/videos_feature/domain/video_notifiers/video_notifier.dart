import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoProvider extends ChangeNotifier {
  VideoProvider(String videoUrl) {
    _initializeController(videoUrl);
  }

  VideoPlayerController? _controller;
  Uint8List? _thumbnail;
  bool _isLiked = false;
  bool _showPlayPauseIcon = false;
  final ValueNotifier<Duration> _positionNotifier =
      ValueNotifier(Duration.zero);
  final ValueNotifier<Duration> _durationNotifier =
      ValueNotifier(Duration.zero);
  final ValueNotifier<bool> _isLikedNotifier = ValueNotifier(false);
  bool _isPaused = false;

  VideoPlayerController? get controller => _controller;
  Uint8List? get thumbnail => _thumbnail;
  bool get isLiked => _isLikedNotifier.value;
  bool get showPlayPauseIcon => _showPlayPauseIcon;
  ValueNotifier<Duration> get positionNotifier => _positionNotifier;
  ValueNotifier<Duration> get durationNotifier => _durationNotifier;
  ValueNotifier<bool> get isLikedNotifier => _isLikedNotifier;
  bool get isPaused => _isPaused;

  Future<void> _initializeController(String videoUrl) async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..setLooping(true);

    await _controller!.initialize();
    _controller!.play();
    _durationNotifier.value = _controller!.value.duration;

    _controller!.addListener(() {
      _positionNotifier.value = _controller!.value.position;
      _isPaused = !_controller!.value.isPlaying;
      notifyListeners();
    });

    await _loadThumbnail(videoUrl);
  }

  Future<void> _loadThumbnail(String videoUrl) async {
    final thumbnailData = await VideoThumbnail.thumbnailData(
      video: videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      quality: 75,
    );

    _thumbnail = thumbnailData;
    notifyListeners();
  }

  void togglePlayPause() {
    if (_controller != null) {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
      _showPlayPauseIcon = true;
      _isPaused = !_controller!.value.isPlaying;
      notifyListeners();

      Future.delayed(const Duration(seconds: 1), () {
        _showPlayPauseIcon = false;
        notifyListeners();
      });
    }
  }

  void toggleLike() {
    _isLiked = !_isLiked;
    _isLikedNotifier.value = _isLiked;
    notifyListeners();
  }

  void seekTo(Duration position) {
    if (_controller != null) {
      _controller!.seekTo(position);
    }
  }

  @override
  void dispose() {
    _positionNotifier.dispose();
    _durationNotifier.dispose();
    _isLikedNotifier.dispose();
    _controller?.dispose();
    super.dispose();
  }
}
