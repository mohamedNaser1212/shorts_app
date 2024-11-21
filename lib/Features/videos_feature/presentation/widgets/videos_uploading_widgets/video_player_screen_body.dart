import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/animated_pause_icon.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/video_preview_slider_widget.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_app_bar.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreenBody extends StatefulWidget {
  const VideoPlayerScreenBody({
    super.key,
    required this.controller,
  });

  final VideoPlayerController controller;

  @override
  State<VideoPlayerScreenBody> createState() => VideoPlayerScreenBodyState();
}

class VideoPlayerScreenBodyState extends State<VideoPlayerScreenBody> {
  final ValueNotifier<Duration> positionNotifier = ValueNotifier(Duration.zero);
  final ValueNotifier<Duration> durationNotifier = ValueNotifier(Duration.zero);

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateState);
    durationNotifier.value = widget.controller.value.duration;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateState);
    positionNotifier.dispose();
    durationNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorController.blackColor,
      appBar: const CustomAppBar(
        title: '',
        showLeadingIcon: true,
        backColor: ColorController.blackColor,
      ),
      body: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
            width: widget.controller.value.size.width,
            height: widget.controller.value.size.height,
            child: Stack(alignment: Alignment.center, children: [
              VideoPlayer(widget.controller),
              AnimatedPauseIcon(
                controller: widget.controller,
                size: 100,
              ),
              VideoSliderWidget(
                state: this,
              ),
            ])),
      ),
    );

    //   Center(
    //     child: AspectRatio(
    //       aspectRatio: 16 / 9,
    //       child: Stack(
    //         alignment: Alignment.center,
    //         children: [
    //           VideoPlayer(widget.controller),
    //           AnimatedPauseIcon(
    //             controller: widget.controller,
    //           ),
    //           VideoSliderWidget(
    //             state: this,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  void _updateState() {
    positionNotifier.value = widget.controller.value.position;
    durationNotifier.value = widget.controller.value.duration;
  }
}
