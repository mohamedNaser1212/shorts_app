import 'package:flutter/material.dart';

import '../managers/styles_manager/color_manager.dart';
import 'custom_title.dart';

class CustomContainerWidget extends StatelessWidget {
  const CustomContainerWidget({
    super.key,
    required this.title,
    this.icon,
    this.onTap,
    this.titleStyle,
    this.textColor,
    this.containerColor,
    this.height,
  });
  final String title;
  final IconData? icon;
  final Function()? onTap;
  final TitleStyle? titleStyle;
  final double? height;
  final Color? textColor;
  final Color? containerColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          color: containerColor ?? ColorController.purpleColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: ColorController.whiteColor,
              ),
              const SizedBox(width: 10),
            ],
            Center(
              child: CustomTitle(
                title: title,
                style: titleStyle ?? TitleStyle.style16,
                color: textColor ?? ColorController.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
