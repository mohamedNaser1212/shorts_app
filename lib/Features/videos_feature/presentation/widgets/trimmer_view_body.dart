import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/play_icon_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/progress_visibility_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/save_video_elevated_botton.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/trimmer_viewer_widget.dart';
import 'package:shorts/core/video_notifiers/video_notifier.dart';
import 'package:video_trimmer/video_trimmer.dart';

class TrimmerViewBody extends StatefulWidget {
  const TrimmerViewBody({super.key, required this.file, });
  final File file;
  @override
  State<TrimmerViewBody> createState() => TrimmerViewBodyState();
}

class TrimmerViewBodyState extends State<TrimmerViewBody> {
    final trimmer = Trimmer();
  double startValue = 0.0;
  double endValue = 0.0;
  bool isPlaying = false;
  bool progressVisibility = false;
  late VideoController videoController;

  @override
  void initState() {
    super.initState();
    _loadVideo();
    videoController =
        VideoController(widget.file.path, isInitiallyPaused: true);
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  void _loadVideo() async {
    await trimmer.loadVideo(videoFile: widget.file);
    final videoDuration =
        trimmer.videoPlayerController!.value.duration.inSeconds;

    setState(() {
      startValue = 0.0;
      endValue = videoDuration < 60 ? videoDuration.toDouble() : 60.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ProgressVisibilityWidget(progressVisibility: progressVisibility),
              const SizedBox(height: 20),
              SaveElevatedBotton(state: this),
              TrimViewerWidget(
                state: this,
              ),
              PlayIcon(state: this),
            ],
          ),
        ),
      );
  }
}