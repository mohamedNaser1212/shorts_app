import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/upload_videos_cubit/upload_videos_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/trimmer_view.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';

import '../../../../core/video_controller/video_controller.dart';
import '../../../../core/widgets/custom_title.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/gallary_icon_widget.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/switch_camera_icon_widget.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/video_recording_icon_widget.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/video_timer_widget.dart';

class VideoSelectionScreen extends StatefulWidget {
  const VideoSelectionScreen({super.key});

  @override
  _VideoSelectionScreenState createState() => _VideoSelectionScreenState();
}

class _VideoSelectionScreenState extends State<VideoSelectionScreen> {
  late VideoController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoController();
    _videoController.requestCameraPermission(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadVideosCubit, UploadVideosState>(
      listener: _listener,
      builder: (context, state) {
        return ChangeNotifierProvider.value(
          value: _videoController,
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
                    // Show camera preview if permission is granted and camera is initialized
                    if (notifier.isPermissionGranted &&
                        notifier.cameraController != null &&
                        notifier.cameraController!.value.isInitialized)
                      CameraPreview(notifier.cameraController!)
                    else if (notifier.isPermissionPermanentlyDenied)
                      // Show message for permanently denied permission
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Camera Permission Denied Permanently",
                            style: TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              openAppSettings();
                            },
                            child: const Text("Go to Settings"),
                          ),
                        ],
                      )
                    else if (notifier.isLoading)
                      // Show loading indicator if permission is still being checked
                      const Center(child: CircularProgressIndicator())
                    else
                      // Show message that camera permission is needed
                      const Center(
                        child: CustomTitle(
                          title: "Camera Needs Permission",
                          style: TitleStyle.styleBold18,
                          color: ColorController.whiteColor,
                        ),
                      ),

                    if (notifier.isRecording)
                      VideoTimerWidget(
                          recordingSeconds: notifier.recordingSeconds),

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
      },
    );
  }

  void _listener(context, state) {
    if (state is VideoPickedSuccess) {
      NavigationManager.navigateTo(
        context: context,
        screen: TrimmerView(
          file: state.file,
        ),
      );
    }
  }
}
