import 'package:flutter/material.dart';

import '../../../../../core/video_controller/video_controller.dart';

class VideoRecordingIconWidget extends StatelessWidget {
  const VideoRecordingIconWidget({
    super.key,
    required this.notifier,
  });

  final VideoController notifier;

  @override
  Widget build(BuildContext context) {
    return notifier.isPermissionGranted
        ? Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 72,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.red,
                    width: 4,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (notifier.isRecording) {
                    notifier.stopRecording();
                  } else {
                    notifier.startRecording();
                  }
                },
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 300),
                  tween: Tween<double>(
                    begin: notifier.isRecording ? 55 : 65,
                    end: notifier.isRecording ? 35 : 55,
                  ),
                  builder: (context, size, child) {
                    return Container(
                      width: size,
                      height: size,
                      decoration: ShapeDecoration(
                        color: Colors.red,
                        shape: notifier.isRecording
                            ? RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              )
                            : const CircleBorder(),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        : Container();
  }
}
