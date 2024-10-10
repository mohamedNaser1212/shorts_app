import 'package:flutter/material.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_icon_widget.dart';

class PlayIconWidget extends StatelessWidget {
  const PlayIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomIconWidget(
      icon: Icons.play_arrow, // Pass the desired icon
    );
  }
}
