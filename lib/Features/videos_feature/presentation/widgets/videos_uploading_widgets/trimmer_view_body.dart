import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/play_icon_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/progress_visibility_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/save_video_elevated_botton.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/trimmer_view_thumbnail_image_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/trimmer_viewer_widget.dart';
import 'package:video_trimmer/video_trimmer.dart';
import '../../../../../core/video_controller/video_controller.dart';

class TrimmerViewBody extends StatefulWidget {
  const TrimmerViewBody({super.key, required this.file});
  final File file;

  @override
  State<TrimmerViewBody> createState() => TrimmerViewBodyState();
}

class TrimmerViewBodyState extends State<TrimmerViewBody> {
  final trimmer = Trimmer();

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
     videoController. startValue = 0.0;
      videoController.endValue = videoDuration < 60 ? videoDuration.toDouble() : 60.0;
    });
  }

  // Future<void> generateThumbnail({
  //   required double seconds,
  //   required String video,
  // }) async {
  //   final thumbnailPath = await VideoThumbnail.thumbnailFile(
  //     video: video,
  //     thumbnailPath: (await getTemporaryDirectory()).path,
  //     imageFormat: ImageFormat.PNG,
  //     maxWidth: 200,
  //     quality: 75,
  //     timeMs: (seconds * 1000).toInt(),
  //   );

  //   if (thumbnailPath != null) {
  //     setState(() {
  //       thumbnailFile = File(thumbnailPath);
  //     });
  //   }
  // }

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
            SaveElevatedButton(
                state: this, thumbnailFile: videoController.thumbnailFile),
            TrimViewerWidget(state: this),
            PlayIcon(state: this),
            if (videoController.thumbnailFile != null)
              TrimmerViewImageWidget(
                  thumbnailFile: videoController.thumbnailFile),
          ],
        ),
      ),
    );
  }
}
