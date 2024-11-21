import 'dart:async';
import 'dart:io';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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
      imageFormat: video_thumbnail.ImageFormat.JPEG,
      maxWidth: 128,
      quality: 75,
    );

    _thumbnail = thumbnailData;
    notifyListeners();
  }

  Future<void> generateThumbnail(
      {required String videoPath, required double seconds}) async {
    final thumbnailPath = await video_thumbnail.VideoThumbnail.thumbnailFile(
      video: videoPath,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: video_thumbnail.ImageFormat.PNG,
      maxWidth: 200,
      quality: 100,
      timeMs: (seconds * 1000).toInt(),
    );
    if (thumbnailPath != null) {
      thumbnailFile = File(thumbnailPath);
      print("Thumbnail generated: ${thumbnailFile!.path}");
      notifyListeners();
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
  static const int maxRecordingDuration = 60;
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

  bool _isPermissionGranted = false;
  bool _isPermissionPermanentlyDenied = false;

  bool get isPermissionGranted => _isPermissionGranted;
  bool get isPermissionPermanentlyDenied => _isPermissionPermanentlyDenied;

  Future<void> requestCameraPermission(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    PermissionStatus status = await Permission.camera.status;

    if (status.isGranted) {
      _isPermissionGranted = true;
      await _initializeCamera();
    } else if (status.isDenied) {
      final result = await Permission.camera.request();
      if (result.isGranted) {
        _isPermissionGranted = true;
        await _initializeCamera();
      } else if (result.isPermanentlyDenied) {
        _isPermissionPermanentlyDenied = true;
      }
    } else if (status.isPermanentlyDenied) {
      _isPermissionPermanentlyDenied = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        final camera = cameras.first;
        _cameraController = CameraController(camera, ResolutionPreset.high);
        await _cameraController!.initialize();
        notifyListeners();
      } else {
        print("No cameras available");
      }
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  int _selectedCameraIndex = 0;

  Future<void> switchCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % cameras.length;

      _cameraController = CameraController(
        cameras[_selectedCameraIndex],
        ResolutionPreset.high,
      );

      try {
        await _cameraController!.initialize();
        notifyListeners();
      } catch (e) {
        print("Error initializing camera: $e");
      }

      if (_isRecording) {
        await startRecording();
      }
    } else {
      print("No cameras available");
    }

    notifyListeners();
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
      _recordingTimer?.cancel();
      _recordingSeconds = 0;

      notifyListeners();

      if (_videoFile != null) {
        await generateThumbnail(videoPath: _videoFile!.path, seconds: 0.1);
      }
    }
  }

  void resetVideoFile() {
    _videoFile = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _positionNotifier.dispose();
    _durationNotifier.dispose();
    _isLikedNotifier.dispose();
    videoController?.dispose();
    _cameraController?.dispose();
    _recordingTimer?.cancel();
    super.dispose();
  }
}
