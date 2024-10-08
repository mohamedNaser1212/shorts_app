import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/play_icon_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/progress_visibility_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/save_video_elevated_botton.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/trimmer_viewer_widget.dart';
import 'package:shorts/core/video_notifiers/video_notifier.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

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
    videoController = VideoController(widget.file.path, isInitiallyPaused: true);
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  void _loadVideo() async {
    await trimmer.loadVideo(videoFile: widget.file);
    final videoDuration = trimmer.videoPlayerController!.value.duration.inSeconds;

    setState(() {
      startValue = 0.0;
      endValue = videoDuration < 60 ? videoDuration.toDouble() : 60.0;
      generateThumbnail(startValue.toInt()); // Generate initial thumbnail
    });
  }

  void generateThumbnail(int seconds) async {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: widget.file.path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      maxWidth: 200, // Specify the width of the thumbnail
      quality: 75,
      timeMs: seconds * 1000, // Get the thumbnail at the specified time in milliseconds
    );

    if (thumbnailPath != null) {
      setState(() {
        thumbnailFile = File(thumbnailPath); // Store the thumbnail
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
            if (thumbnailFile != null)
              Image.file(
                thumbnailFile!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ProgressVisibilityWidget(progressVisibility: progressVisibility),
            const SizedBox(height: 20),
            // Pass the thumbnail to the SaveElevatedBotton
            SaveElevatedBotton(state: this, thumbnailFile: thumbnailFile),
            TrimViewerWidget(state: this),
            PlayIcon(state: this),
          ],
        ),
      ),
    );
  }
}
