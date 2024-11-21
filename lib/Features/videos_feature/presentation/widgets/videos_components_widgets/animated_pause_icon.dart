import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/video_controller/video_controller.dart';

class AnimatedPauseIcon extends StatefulWidget {
  final VideoController? videoController;
  final VideoPlayerController? controller;
  final int? size;

  const AnimatedPauseIcon({
    super.key,
    this.videoController,
    this.controller,
    this.size = 60,
  });

  @override
  State<AnimatedPauseIcon> createState() => _AnimatedPauseIconState();
}

class _AnimatedPauseIconState extends State<AnimatedPauseIcon>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final ValueNotifier<bool> _isPlayingNotifier;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _isPlayingNotifier = ValueNotifier<bool>(
        widget.videoController?.controller?.value.isPlaying ??
            widget.controller!.value.isPlaying);

    widget.videoController?.controller?.addListener(_updateIconState);
    widget.controller?.addListener(_updateIconState);
  }

  void _updateIconState() {
    final isPlaying = widget.videoController?.controller?.value.isPlaying ??
        widget.controller!.value.isPlaying;

    _isPlayingNotifier.value = isPlaying;
    if (isPlaying) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    widget.videoController?.controller?.removeListener(_updateIconState);
    widget.controller?.removeListener(_updateIconState);
    _animationController.dispose();
    _isPlayingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Toggle play/pause state on tap
        if (widget.videoController != null) {
          widget.videoController!.togglePlayPause();
        } else if (widget.controller != null) {
          if (widget.controller!.value.isPlaying) {
            widget.controller!.pause();
          } else {
            widget.controller!.play();
          }
        }
      },
      child: Center(
        child: ValueListenableBuilder<bool>(
          valueListenable: _isPlayingNotifier,
          builder: (context, isPlaying, child) {
            return AnimatedOpacity(
              opacity: isPlaying ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 500),
              child: AnimatedIcon(
                icon: AnimatedIcons.play_pause,
                progress: _animationController,
                size: widget.size!.toDouble(),
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
