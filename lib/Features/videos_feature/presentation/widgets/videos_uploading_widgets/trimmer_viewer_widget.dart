import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/trimmer_view_body.dart';
import 'package:video_trimmer/video_trimmer.dart';

class TrimViewerWidget extends StatefulWidget {
  const TrimViewerWidget({
    super.key,
    required this.state,
  });

  final TrimmerViewBodyState state;

  @override
  State<TrimViewerWidget> createState() => _TrimViewerWidgetState();
}

class _TrimViewerWidgetState extends State<TrimViewerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TrimViewer(
        trimmer: widget.state.trimmer,
        viewerHeight: 50.0,
        viewerWidth: MediaQuery.of(context).size.width,
        durationStyle: DurationStyle.FORMAT_MM_SS,
        maxVideoLength: const Duration(seconds: 60),
        editorProperties: TrimEditorProperties(
          borderPaintColor: Colors.yellow,
          borderWidth: 6,
          borderRadius: 6,
          circlePaintColor: Colors.yellow.shade800,
        ),
        areaProperties: TrimAreaProperties.edgeBlur(thumbnailQuality: 10),
        onChangeStart: (value) {
         // setState(() {

            widget.state.videoController.startValue = value;
            widget.state.videoController
                .seekTo(Duration(seconds: value.toInt()));
            widget.state.videoController.positionNotifier.value =
                Duration(seconds: value.toInt());
            _updateThumbnail(value);
         // });
        },
        onChangeEnd: (value) {
          // setState(() {

            widget.state.videoController.endValue = value;
            if (widget.state.videoController.positionNotifier.value.inSeconds >
                value) {
              _updateVideoPosition();
            }
            _updateThumbnail(value);
      //    });
        },
        onChangePlaybackState: (value) {
         // setState(() {
            widget.state.isPlaying = value;
            if (value) {
              widget.state.videoController.togglePlayPause();
            }
        //  });
        },
      ),
    );
  }

  void _updateVideoPosition() {
    // Seek to the start value if the current position exceeds the end value
    widget.state.videoController.seekTo(
      Duration(seconds: widget.state.videoController.startValue.toInt()),
    );
  }

  void _updateThumbnail(double value) {
    // Generate a new thumbnail based on the current position
    if (widget.state.videoController.thumbnailFile != null) {
      widget.state.videoController.generateThumbnail(
        seconds: value.toDouble(),
        videoPath: widget.state.videoController.thumbnailFile!.path,
      );
    }
  }
}
