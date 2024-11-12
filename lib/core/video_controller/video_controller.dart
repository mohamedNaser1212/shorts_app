import 'dart:async';
import 'dart:io';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart' as video_thumbnail;

class VideoController extends ChangeNotifier {
  VideoController({String? videoUrl, bool isInitiallyPaused = false}) {
    if (videoUrl != null) {
      initializeController(
          videoUrl: videoUrl, isInitiallyPaused: isInitiallyPaused);
    }
  }

  File? thumbnailFile;
  CachedVideoPlayerController? videoController;
  Uint8List? _thumbnail;
  bool _isLiked = false;
  bool _showPlayPauseIcon = false;
  final ValueNotifier<Duration> _positionNotifier =
      ValueNotifier(Duration.zero);
  final ValueNotifier<Duration> _durationNotifier =
      ValueNotifier(Duration.zero);
  final ValueNotifier<bool> _isLikedNotifier = ValueNotifier(false);
  bool _isPaused = false;
  double startValue = 0.0;
  double endValue = 0.0;

  CachedVideoPlayerController? get controller => videoController;
  Uint8List? get thumbnail => _thumbnail;
  bool get isLiked => _isLikedNotifier.value;
  bool get showPlayPauseIcon => _showPlayPauseIcon;
  ValueNotifier<Duration> get positionNotifier => _positionNotifier;
  ValueNotifier<Duration> get durationNotifier => _durationNotifier;
  ValueNotifier<bool> get isLikedNotifier => _isLikedNotifier;
  bool get isPaused => _isPaused;

  Future<void> initializeController({
    required String videoUrl,
    required bool isInitiallyPaused,
  }) async {
    videoController = CachedVideoPlayerController.network(videoUrl)
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

    // Optionally load thumbnail
    // await _loadThumbnail(videoUrl);
  }

  int _selectedCameraIndex = 0;

  Future<void> switchCamera() async {
    if (_cameras == null || _cameras!.isEmpty) return;

    // Check if we are recording
    if (_isRecording) {
      // Stop recording before switching cameras
      await stopRecording();
    }

    // Switch to the next camera
    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras!.length;
    _cameraController = CameraController(
      _cameras![_selectedCameraIndex],
      ResolutionPreset.high,
    );

    await _cameraController?.initialize();

    if (_isRecording) {
      await startRecording();
    }

    notifyListeners();
  }

  Future<void> loadVideo({
    required File videoFile,
  }) async {
    videoController = CachedVideoPlayerController.file(videoFile);
    await videoController!.initialize();
    _durationNotifier.value = videoController!.value.duration;
    notifyListeners();
  }

  Future<void> _loadThumbnail(String videoUrl) async {
    final thumbnailData = await video_thumbnail.VideoThumbnail.thumbnailData(
      video: videoUrl,
      imageFormat:
          video_thumbnail.ImageFormat.JPEG, // Use the aliased version here
      maxWidth: 128,
      quality: 75,
    );

    _thumbnail = thumbnailData;
    notifyListeners();
  }

  Future<void> generateThumbnail({
    required String videoPath,
    required double seconds,
  }) async {
    final thumbnailPath = await video_thumbnail.VideoThumbnail.thumbnailFile(
      video: videoPath,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: video_thumbnail.ImageFormat.PNG,
      maxWidth: 200,
      quality: 75,
      timeMs: (seconds * 1000).toInt(),
    );

    if (thumbnailPath != null) {
      thumbnailFile = File(thumbnailPath);
      _thumbnail = await thumbnailFile!.readAsBytes();
      notifyListeners();
    } else {
      print("Thumbnail generation failed.");
    }
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

  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isRecording = false;
  bool _isLoading = false;
  Timer? _recordingTimer;
  int _recordingSeconds = 0;
  static const int maxRecordingDuration = 60; // 60 seconds
  XFile? _videoFile;
  VideoController? _videoController;

  CameraController? get cameraController => _cameraController;
  bool get isRecording => _isRecording;
  bool get isLoading => _isLoading;
  int get recordingSeconds => _recordingSeconds;
  XFile? get videoFile => _videoFile;
  VideoController? get videoControllerInstance => _videoController;

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _cameraController = CameraController(
        _cameras![0],
        ResolutionPreset.high,
      );
      await _cameraController?.initialize();
      notifyListeners();
    }
  }

  Future<void> startRecording() async {
    if (_cameraController != null &&
        _cameraController!.value.isInitialized &&
        !_isRecording) {
      await _cameraController?.startVideoRecording();
      _isRecording = true;
      _recordingSeconds = 0;
      notifyListeners();
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_recordingSeconds >= 60) {
          stopRecording();
        } else {
          _recordingSeconds++;
          notifyListeners();
        }
      });
    }
  }

  Future<void> stopRecording() async {
    if (_cameraController != null &&
        _cameraController!.value.isRecordingVideo) {
      final videoFile = await _cameraController?.stopVideoRecording();
      _isRecording = false;
      _videoFile = videoFile;
      notifyListeners();

      if (_videoFile != null) {
        initializeVideoController(_videoFile!.path);
        await generateThumbnail(videoPath: _videoFile!.path, seconds: 0.1);
      }
    }
  }

  void initializeVideoController(String videoPath) {
    _videoController = VideoController(videoUrl: videoPath)
      ..generateThumbnail(videoPath: videoPath, seconds: 1.0).then((_) {
        notifyListeners();
      });
  }

  @override
  void dispose() {
    _positionNotifier.dispose();
    _durationNotifier.dispose();
    _isLikedNotifier.dispose();
    videoController?.dispose();
    _cameraController?.dispose();
    _recordingTimer?.cancel();
    _videoController?.dispose();
    super.dispose();
  }
}
