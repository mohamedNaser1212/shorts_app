import 'package:flutter/material.dart';

import '../managers/styles_manager/color_manager.dart';
import 'custom_title.dart';

class CustomContainerWidget extends StatelessWidget {
  const CustomContainerWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorController.purpleColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: ColorController.whiteColor,
            ),
            const SizedBox(width: 10),
            CustomTitle(
              title: title,
              style: TitleStyle.style16,
              color: ColorController.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
