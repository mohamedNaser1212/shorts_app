import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/trimmer_view_body.dart';
import 'package:video_trimmer/video_trimmer.dart';

class TrimViewerWidget extends StatefulWidget {
  const TrimViewerWidget({
    super.key,
    required this.state,
  });
  final TrimmerViewBodyState state;
  // final File file;
  // double startValue;
  // double endValue;
  // bool isPlaying;
  // final Trimmer trimmer;
  // final VideoController videoController;

  @override
  State<TrimViewerWidget> createState() => _TrimViewerWidgetState();
}

class _TrimViewerWidgetState extends State<TrimViewerWidget> {
  // double _startValue = 0.0;
  // double _endValue = 0.0;
  // bool _isPlaying = false;
  // bool _progressVisibility = false;

  @override
  void initState() {
    super.initState();

    // _videoController =
    //     VideoController(widget.file.path, isInitiallyPaused: true);
  }

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
          setState(() {
            widget.state.startValue = value;
            _updateVideoPosition();
          });
        },
        onChangeEnd: (value) {
          setState(() {
            widget.state.endValue = value;

            if (widget.state.videoController.positionNotifier.value.inSeconds >
                widget.state.endValue) {
              _updateVideoPosition();
            }
          });
        },
        onChangePlaybackState: (value) => setState(() {
          widget.state.isPlaying = value;
        }),
      ),
    );
  }

  void _updateVideoPosition() {
    widget.state.videoController
        .seekTo(Duration(seconds: widget.state.startValue.toInt()));
  }
}
