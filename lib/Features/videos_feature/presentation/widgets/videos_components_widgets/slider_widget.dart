import 'package:flutter/material.dart';

import '../../../../../core/video_controller/video_controller.dart';
import 'duration_notifier_widget.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({
    super.key,
    required this.videoProvider,
  });

  final VideoController videoProvider;

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  late final VoidCallback _positionListener;
  late final VoidCallback _durationListener;

  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  @override
  void initState() {
    super.initState();

    _positionListener = () {
      setState(() {
        _position = widget.videoProvider.positionNotifier.value;
      });
    };
    widget.videoProvider.positionNotifier.addListener(_positionListener);

    _durationListener = () {
      setState(() {
        _duration = widget.videoProvider.durationNotifier.value;
      });
    };
    widget.videoProvider.durationNotifier.addListener(_durationListener);
  }

  @override
  void dispose() {
    widget.videoProvider.positionNotifier.removeListener(_positionListener);
    widget.videoProvider.durationNotifier.removeListener(_durationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: AnimatedOpacity(
        opacity: widget.videoProvider.isPaused ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Slider(
              value: _position.inMilliseconds.toDouble(),
              min: 0.0,
              max: _duration.inMilliseconds.toDouble(),
              onChanged: (value) {
                widget.videoProvider
                    .seekTo(Duration(milliseconds: value.toInt()));
              },
            ),
            DurationNotifier(videoProvider: widget.videoProvider),
          ],
        ),
      ),
    );
  }
}
