import 'package:flutter/material.dart';

import '../../../../../core/video_controller/video_controller.dart';

class DurationNotifier extends StatefulWidget {
  const DurationNotifier({super.key, required this.videoProvider});

  final VideoController videoProvider;

  @override
  State<DurationNotifier> createState() => _DurationNotifierState();
}

class _DurationNotifierState extends State<DurationNotifier> {
  late final VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    _listener = () {
      setState(() {});
    };
    widget.videoProvider.positionNotifier.addListener(_listener);
    widget.videoProvider.durationNotifier.addListener(_listener);
  }

  @override
  void dispose() {
    widget.videoProvider.positionNotifier.removeListener(_listener);
    widget.videoProvider.durationNotifier.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final position = widget.videoProvider.positionNotifier.value;
    final duration = widget.videoProvider.durationNotifier.value;

    return Text(
      '${_formatDuration(position)} / ${_formatDuration(duration)}',
      style: const TextStyle(color: Colors.white),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
