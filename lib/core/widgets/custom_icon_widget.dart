import 'package:flutter/material.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';

class CustomIconWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;

  const CustomIconWidget({
    super.key,
    required this.icon,
    this.color = ColorController.greyColor,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color,
      size: size,
    );
  }
}
