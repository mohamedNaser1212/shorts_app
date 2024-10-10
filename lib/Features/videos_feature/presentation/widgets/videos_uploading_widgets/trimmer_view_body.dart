import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/play_icon_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/progress_visibility_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/save_video_elevated_botton.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/trimmer_viewer_widget.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:video_trimmer/video_trimmer.dart';

import '../../../../../core/video_notifiers/video_notifier.dart';

class TrimmerViewBody extends StatefulWidget {
  const TrimmerViewBody({super.key, required this.file});
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
  File? thumbnailFile; // Variable to store the thumbnail

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

  Future<void> generateThumbnail(double seconds, String video) async {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: video,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      maxWidth: 200,
      quality: 75,
      timeMs: (seconds * 1000).toInt(),
    );

    if (thumbnailPath != null) {
      setState(() {
        thumbnailFile = File(thumbnailPath);
      });
    }
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
            SaveElevatedBotton(
              state: this,
              // Pass thumbnailFile only if needed
              thumbnailFile: thumbnailFile,
            ),
            TrimViewerWidget(state: this),
            PlayIcon(state: this),
            // Optionally display thumbnail if available
            if (thumbnailFile != null)
              Image.file(thumbnailFile!, width: 200, height: 200),
          ],
        ),
      ),
    );
  }
}
