import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart'; // Import flutter_xlider package

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
      bottom: 0, // Align the slider to the bottom of the screen
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        opacity: widget.videoProvider.isPaused ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FlutterSlider(
              values: [_position.inMilliseconds.toDouble()],
              max: _duration.inMilliseconds.toDouble(),
              min: 0,
              handler: FlutterSliderHandler(
                decoration: const BoxDecoration(
                  color: Colors.transparent, // Make the thumb transparent
                ),
              ),
              trackBar: FlutterSliderTrackBar(
                activeTrackBar: BoxDecoration(
                  color: Colors.blue, // Set color of active track
                  borderRadius:
                      BorderRadius.circular(2.0), // Add slight rounding
                ),
                inactiveTrackBar: BoxDecoration(
                  color: Colors.grey
                      .withOpacity(0.5), // Set color of inactive track
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              onDragging: (handlerIndex, lowerValue, upperValue) {
                widget.videoProvider
                    .seekTo(Duration(milliseconds: lowerValue.toInt()));
              },
            ),
            DurationNotifier(videoProvider: widget.videoProvider),
          ],
        ),
      ),
    );
  }
}
