import 'package:flutter/material.dart';
import '../../../../../core/video_controller/video_controller.dart';

class AnimatedPauseIcon extends StatefulWidget {
  const AnimatedPauseIcon({
    super.key,
    required this.videoProvider,
  });

  final VideoController videoProvider;

  @override
  State<AnimatedPauseIcon> createState() => _AnimatedPauseIconState();
}

class _AnimatedPauseIconState extends State<AnimatedPauseIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Set listener to update UI
    _listener = () {
      setState(() {
        if (widget.videoProvider.controller?.value.isPlaying ?? false) {
          _animationController.forward(); // Play icon animation
        } else {
          _animationController.reverse(); // Pause icon animation
        }
      });
    };

    widget.videoProvider.addListener(_listener);
  }

  @override
  void dispose() {
    widget.videoProvider.removeListener(_listener);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        opacity: widget.videoProvider.showPlayPauseIcon ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: AnimatedIcon(
          icon: AnimatedIcons.play_pause, // Play and pause animation
          progress: _animationController, // Animation progress
          size: 60.0,
          color: Colors.white, // You can customize the icon color
        ),
      ),
    );
  }
}
