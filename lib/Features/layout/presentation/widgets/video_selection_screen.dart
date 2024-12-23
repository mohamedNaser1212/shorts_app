import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/upload_videos_cubit/upload_videos_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/trimmer_view.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';

import '../../../../core/video_controller/video_controller.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/check_on_camera_permissions_widgets.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/gallary_icon_widget.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/switch_camera_icon_widget.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/video_recording_icon_widget.dart';
import '../../../videos_feature/presentation/widgets/videos_uploading_widgets/video_timer_widget.dart';

class VideoSelectionScreen extends StatefulWidget {
  const VideoSelectionScreen({super.key});

  @override
  _VideoSelectionScreenState createState() => _VideoSelectionScreenState();
}

class _VideoSelectionScreenState extends State<VideoSelectionScreen>
    with WidgetsBindingObserver {
  late VideoController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoController();
    _videoController.requestCameraPermission(context);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _videoController.requestCameraPermission(context);
    }
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
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                  CheckOnCameraPermissionsWidgets(notifier: notifier),
                  if (notifier.isRecording)
                    VideoTimerWidget(
                        recordingSeconds: notifier.recordingSeconds),
                  VideoRecordingIconWidget(notifier: notifier),
                  GallaryIconWidget(notifier: notifier),
                  SwitchCameraIconWidget(notifier: notifier),
                ],
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
