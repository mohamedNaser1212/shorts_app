import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/trimmer_view_body.dart';

class PlayIcon extends StatefulWidget {
  const PlayIcon({super.key, required this.state});
  final TrimmerViewBodyState state;
  @override
  State<PlayIcon> createState() => _PlayIconState();
}

class _PlayIconState extends State<PlayIcon> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final playBackState = await widget.state.trimmer.videoPlaybackControl(
          endValue: widget.state.endValue,
          startValue: widget.state.startValue,
        );
        setState(() {
          widget.state.isPlaying = playBackState;
        });
      },
      child: widget.state.isPlaying
          ? const Icon(Icons.pause)
          : const Icon(Icons.play_arrow),
    );
  }
}
