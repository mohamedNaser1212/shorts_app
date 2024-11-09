import 'package:flutter/material.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';

class CustomBackIconWidget extends StatelessWidget {
  final double size;
  final VoidCallback onPressed;

  const CustomBackIconWidget({
    super.key,
    this.size = 32,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.arrow_back_outlined,
        color: ColorController.whiteColor,
        size: size,
      ),
    );
  }
}
