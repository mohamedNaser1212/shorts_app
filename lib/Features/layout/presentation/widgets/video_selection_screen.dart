import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/upload_video_use_case/upload_video_use_case.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/upload_videos_cubit/upload_videos_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/trimmer_view.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/functions/toast_function.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/service_locator/service_locator.dart';

import '../../../../core/video_controller/video_controller.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/confirm_recording_widget.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/gallary_icon_widget.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/video_recording_icon_widget.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/video_timer_widget.dart';

class VideoSelectionScreen extends StatelessWidget {
  const VideoSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VideoController()..initializeCamera(),
      child: Consumer<VideoController>(
        builder: (context, notifier, _) {
          return BlocProvider(
            create: (context) => UploadVideosCubit(
              uploadVideoUseCase: getIt.get<UploadVideoUseCase>(),
            ),
            child: BlocConsumer<UploadVideosCubit, UploadVideosState>(
              listener: _listener,
              builder: (context, state) => Scaffold(
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
                        VideoTimerWidget(
                            recordingSeconds: notifier.recordingSeconds),
                      if (notifier.videoFile != null && !notifier.isRecording)
                        ConfirmRecordingWidget(
                          videoFile: notifier.videoFile,
                          videoController: notifier.videoControllerInstance,
                        ),
                      VideoRecordingIconWidget(notifier: notifier),
                      const GallaryIconWidget(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _listener(BuildContext context, UploadVideosState state) {
    final videoNotifier = context.read<VideoController>();

    if (state is VideoPickedSuccess) {
      videoNotifier.initializeVideoController(state.file.path);

      if (videoNotifier.thumbnailFile == null) {
        videoNotifier.generateThumbnail(
          videoPath: state.file.path,
          seconds: 1.0,
        );
      }

      if (videoNotifier.thumbnailFile == null) {
        ToastHelper.showToast(
            message: "Thumbnail generation failed, pleaSe try again.");
      } else {
        NavigationManager.navigateTo(
          context: context,
          screen: TrimmerView(
            file: state.file,
          ),
        );
      }
    } else if (state is VideoPickedError) {
      ToastHelper.showToast(message: state.message);
    }
  }
}
