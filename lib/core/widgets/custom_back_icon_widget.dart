import 'package:flutter/material.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';

class CustomBackIconWidget extends StatelessWidget {
  final double size;
  final VoidCallback? onPressed;

  const CustomBackIconWidget({
    super.key,
    this.size = 32,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () => Navigator.pop(context),
      icon: Icon(
        Icons.arrow_back_outlined,
        color: ColorController.whiteColor,
        size: size,
      ),
    );
  }
}
