import 'package:flutter/material.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/managers/styles_manager/text_styles_manager.dart';

class ReusableElevatedButton extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Color backColor;
  final Color textColor;
  final String label;
  final void Function()? onPressed;

  const ReusableElevatedButton({
    super.key,
    this.width = double.infinity,
    this.height = 50,
    this.radius = 10,
    this.backColor = ColorController.blueAccent,
    this.textColor = ColorController.whiteColor,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backColor, 
          
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: StylesManager.textStyle20
              .copyWith(color: textColor, fontSize: 20),
        ),
      ),
    );
  }
}
