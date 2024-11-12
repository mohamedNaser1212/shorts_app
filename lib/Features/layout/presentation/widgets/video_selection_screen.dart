import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';

import '../../../../core/video_controller/video_controller.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/gallary_icon_widget.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/switch_camera_icon_widget.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/video_recording_icon_widget.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/video_timer_widget.dart';

class VideoSelectionScreen extends StatelessWidget {
  const VideoSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VideoController()..initializeCamera(),
      child: Consumer<VideoController>(builder: (context, notifier, _) {
        return Scaffold(
          backgroundColor: ColorController.blackColor,
          body: Center(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
                notifier.cameraController != null &&
                        notifier.cameraController!.value.isInitialized
                    ? CameraPreview(notifier.cameraController!)
                    : const Center(child: CircularProgressIndicator()),
                if (notifier.isRecording)
                  VideoTimerWidget(recordingSeconds: notifier.recordingSeconds),
                // if (notifier.videoFile != null && !notifier.isRecording)
                //   ConfirmRecordingWidget(
                //     videoFile: notifier.videoFile,
                //     videoController: notifier.videoControllerInstance,
                //   ),
                VideoRecordingIconWidget(notifier: notifier),
                GallaryIconWidget(
                  notifier: notifier,
                ),
                SwitchCameraIconWidget(
                  notifier: notifier,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
