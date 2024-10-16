import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoController extends ChangeNotifier {
  VideoController(String videoUrl, {bool isInitiallyPaused = false}) {
    initializeController(videoUrl: videoUrl, isInitiallyPaused: isInitiallyPaused);
  }

  VideoPlayerController? videoController;
  Uint8List? _thumbnail;
  bool _isLiked = false;
  bool _showPlayPauseIcon = false;
  final ValueNotifier<Duration> _positionNotifier =
      ValueNotifier(Duration.zero);
  final ValueNotifier<Duration> _durationNotifier =
      ValueNotifier(Duration.zero);
  final ValueNotifier<bool> _isLikedNotifier = ValueNotifier(false);
  bool _isPaused = false;

  VideoPlayerController? get controller => videoController;
  Uint8List? get thumbnail => _thumbnail;
  bool get isLiked => _isLikedNotifier.value;
  bool get showPlayPauseIcon => _showPlayPauseIcon;
  ValueNotifier<Duration> get positionNotifier => _positionNotifier;
  ValueNotifier<Duration> get durationNotifier => _durationNotifier;
  ValueNotifier<bool> get isLikedNotifier => _isLikedNotifier;
  bool get isPaused => _isPaused;

  Future<void> initializeController(
      {required String videoUrl, required bool isInitiallyPaused}) async {
    videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..setLooping(true);

    await videoController!.initialize();

    if (isInitiallyPaused) {
      videoController!.pause();
      _isPaused = true;
    } else {
      videoController!.play();
      _isPaused = false;
    }

    _durationNotifier.value = videoController!.value.duration;

    videoController!.addListener(() {
      _positionNotifier.value = videoController!.value.position;
      _isPaused = !videoController!.value.isPlaying;
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
    if (videoController != null) {
      if (videoController!.value.isPlaying) {
        videoController!.pause();
      } else {
        videoController!.play();
      }
      _showPlayPauseIcon = true;
      _isPaused = !videoController!.value.isPlaying;
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
    if (videoController != null) {
      videoController!.seekTo(position);
    }
  }

  @override
  void dispose() {
    _positionNotifier.dispose();
    _durationNotifier.dispose();
    _isLikedNotifier.dispose();
    videoController?.dispose();
    super.dispose();
  }
}
