import 'package:flutter/material.dart';
import 'package:shorts/core/utils/styles_manager/text_styles_manager.dart';


class ReusableElevatedButton extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Color backColor;
  final Color textColor;
  final String label;
  final void Function()? onPressed;

  const ReusableElevatedButton({
    Key? key,
    this.width = double.infinity,
    this.height = 50,
    this.radius = 10,
    this.backColor = Colors.blue,
    this.textColor = Colors.white,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
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
