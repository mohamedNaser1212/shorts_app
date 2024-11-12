import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shorts/core/video_controller/video_controller.dart';

class VideoRecordingNotifier extends ChangeNotifier {
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
      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_recordingSeconds >= maxRecordingDuration) {
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
      _recordingTimer?.cancel();
      _videoFile = videoFile;
      notifyListeners();

      if (_videoFile != null) {
        initializeVideoController(_videoFile!.path);
      }
    }
  }

  void initializeVideoController(String videoPath) {
    _videoController = VideoController( videoUrl: videoPath, )
      ..generateThumbnail(videoPath: videoPath, seconds: 1.0).then((_) {
        notifyListeners();
      });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _recordingTimer?.cancel();
    _videoController?.dispose();
    super.dispose();
  }
}
