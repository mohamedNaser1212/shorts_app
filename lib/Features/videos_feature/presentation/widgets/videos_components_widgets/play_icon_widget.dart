import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/trimmer_view_body.dart';
import 'package:shorts/core/widgets/pause_icon_widget.dart';
import 'package:shorts/core/widgets/play_icon_widget.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class PlayIcon extends StatefulWidget {
  PlayIcon({super.key, this.state, this.videoPlayerScreenState});
  TrimmerViewBodyState? state;
  VideoPlayerController? videoPlayerScreenState;

  @override
  State<PlayIcon> createState() => _PlayIconState();
}

class _PlayIconState extends State<PlayIcon> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (widget.state != null) {
          final playBackState =
              await widget.state?.trimmer.videoPlaybackControl(
            endValue: widget.state?.videoController.endValue ??
                widget.videoPlayerScreenState!.value.duration.inSeconds
                    .toDouble(),
            startValue: widget.state?.videoController.startValue ??
                widget.videoPlayerScreenState!.value.duration.inSeconds
                    .toDouble(),
          );
          setState(() {
            widget.state!.isPlaying = playBackState ?? false;
          });
        } else if (widget.videoPlayerScreenState != null) {
          if (widget.videoPlayerScreenState!.value.isPlaying) {
            widget.videoPlayerScreenState!.pause();
          } else {
            widget.videoPlayerScreenState!.play();
          }
          setState(() {});
        }
      },
      child: widget.state != null
          ? (widget.state!.isPlaying
              ? const PauseIconWidget()
              : const PlayIconWidget())
          : (widget.videoPlayerScreenState?.value.isPlaying ?? false
              ? const PauseIconWidget()
              : const PlayIconWidget()),
    );
  }
}
