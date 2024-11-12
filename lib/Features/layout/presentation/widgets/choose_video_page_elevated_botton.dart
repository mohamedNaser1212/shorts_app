import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/upload_video_use_case/upload_video_use_case.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/upload_videos_cubit/upload_videos_cubit.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/functions/toast_function.dart';
import 'package:shorts/core/service_locator/service_locator.dart';

import '../../../../core/video_controller/video_controller.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/confirm_recording_widget.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/preview_screen.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/video_timer_widget.dart';

class VideoSelectionScreen extends StatefulWidget {
  const VideoSelectionScreen({super.key});

  @override
  State<VideoSelectionScreen> createState() => _VideoSelectionScreenState();
}

class _VideoSelectionScreenState extends State<VideoSelectionScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isRecording = false;
  bool _isLoading = false;
  Timer? _recordingTimer;
  int _recordingSeconds = 0;
  static const int maxRecordingDuration = 60; // 60 seconds
  XFile? _videoFile;
  VideoController? _videoController;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _cameraController = CameraController(
        _cameras![0],
        ResolutionPreset.high,
      );
      await _cameraController?.initialize();
      if (mounted) setState(() {});
    }
  }

  Future<void> _startRecording() async {
    if (_cameraController != null &&
        _cameraController!.value.isInitialized &&
        !_isRecording) {
      await _cameraController?.startVideoRecording();
      setState(() {
        _isRecording = true;
        _recordingSeconds = 0;
      });
      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_recordingSeconds >= maxRecordingDuration) {
          _stopRecording();
        } else {
          setState(() => _recordingSeconds++);
        }
      });
    }
  }

  Future<void> _stopRecording() async {
    if (_cameraController != null &&
        _cameraController!.value.isRecordingVideo) {
      final videoFile = await _cameraController?.stopVideoRecording();
      setState(() {
        _isRecording = false;
        _recordingTimer?.cancel();
        _videoFile = videoFile;
      });

      if (_videoFile != null) {
        _initializeVideoController(_videoFile!.path);
      }
    }
  }

  void _initializeVideoController(String videoPath) {
    _videoController = VideoController(videoPath)
      ..generateThumbnail(videoPath: videoPath, seconds: 1.0).then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _recordingTimer?.cancel();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => UploadVideosCubit(
          uploadVideoUseCase: getIt.get<UploadVideoUseCase>(),
        ),
        child: BlocConsumer<UploadVideosCubit, UploadVideosState>(
          listener: _listener,
          builder: (context, state) => Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Camera Preview
              _cameraController != null &&
                      _cameraController!.value.isInitialized
                  ? CameraPreview(_cameraController!)
                  : const Center(child: CircularProgressIndicator()),

              if (_isRecording)
                VideoTimerWidget(recordingSeconds: _recordingSeconds),

              if (_videoFile != null && !_isRecording)
                ConfirmRecordingWidget(
                  videoFile: _videoFile,
                  videoController: _videoController,
                ),

              Positioned(
                bottom: 16.0,
                left: 16.0,
                right: 16.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Gallery button
                    IconButton(
                      icon: const Icon(Icons.video_library,
                          color: Colors.white, size: 30),
                      onPressed: () {
                        UploadVideosCubit.get(context).pickVideo();
                      },
                    ),

                    // Record button
                    FloatingActionButton(
                      onPressed:
                          _isRecording ? _stopRecording : _startRecording,
                      backgroundColor: _isRecording ? Colors.red : Colors.white,
                      child: Icon(
                        _isRecording ? Icons.stop : Icons.videocam,
                        color: _isRecording ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, UploadVideosState state) {
    if (state is VideoPickedSuccess) {
      setState(() => _isLoading = false);
      _initializeVideoController(state.file.path);
      NavigationManager.navigateTo(
        context: context,
        screen: PreviewScreen(
          outputPath: state.file.path,
          thumbnailFile: _videoController?.thumbnailFile,
        ),
      );
    } else if (state is VideoPickedLoading) {
      setState(() => _isLoading = true);
    } else if (state is VideoPickedError) {
      setState(() => _isLoading = false);
      ToastHelper.showToast(message: state.message);
    }
  }
}
