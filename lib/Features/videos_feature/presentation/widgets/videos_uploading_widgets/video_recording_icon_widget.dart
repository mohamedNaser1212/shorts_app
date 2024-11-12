import 'package:flutter/material.dart';
import 'package:shorts/core/video_controller/video_controller.dart';

class VideoRecordingIcon extends StatelessWidget {
  const VideoRecordingIcon({
    super.key,
    required this.notifier,
  });
  final VideoController notifier;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: notifier.isRecording
          ? notifier.stopRecording
          : notifier.startRecording,
      backgroundColor: notifier.isRecording ? Colors.red : Colors.white,
      child: Icon(
        notifier.isRecording ? Icons.stop : Icons.videocam,
        color: notifier.isRecording ? Colors.white : Colors.black,
      ),
    );
  }
}
