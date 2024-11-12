import 'package:flutter/material.dart';

class VideoTimerWidget extends StatelessWidget {
  const VideoTimerWidget({
    super.key,
    required int recordingSeconds,
  }) : _recordingSeconds = recordingSeconds;

  final int _recordingSeconds;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      left: 20,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "${_recordingSeconds ~/ 60}:${(_recordingSeconds % 60).toString().padLeft(2, '0')}",
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
