import 'package:flutter/material.dart';

import '../../../../core/video_notifiers/video_notifier.dart';

class AnimatedPauseIcon extends StatefulWidget {
  const AnimatedPauseIcon({
    super.key,
    required this.videoProvider,
  });

  final VideoController videoProvider;

  @override
  State<AnimatedPauseIcon> createState() => _AnimatedPauseIconState();
}

class _AnimatedPauseIconState extends State<AnimatedPauseIcon> {
  late final VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    _listener = () {
      setState(() {});
    };
    widget.videoProvider.addListener(_listener);
  }

  @override
  void dispose() {
    widget.videoProvider.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        opacity: widget.videoProvider.showPlayPauseIcon ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Icon(
          widget.videoProvider.controller?.value.isPlaying ?? false
              ? Icons.pause
              : Icons.play_arrow,
          color: Colors.white,
          size: 80,
        ),
      ),
    );
  }
}
