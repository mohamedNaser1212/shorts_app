import 'package:flutter/material.dart';
import 'package:shorts/core/widgets/custom_title.dart';

class DurationWidget extends StatelessWidget {
  const DurationWidget({
    super.key,
    required this.positionNotifier,
  });

  final ValueNotifier<Duration> positionNotifier;

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Duration>(
      valueListenable: positionNotifier,
      builder: (context, duration, child) {
        return CustomTitle(
          title: _formatDuration(duration),
          style: TitleStyle.styleBold18,
        );
      },
    );
  }
}
