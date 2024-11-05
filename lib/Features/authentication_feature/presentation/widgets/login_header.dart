import 'package:flutter/material.dart';

import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitle(
              title: title,
              style: TitleStyle.style30Bold,
              color: ColorController.purpleColor,
            ),
            const SizedBox(height: 5),
            const CustomTitle(
              title: 'Save Soul',
              style: TitleStyle.style16,
              color: ColorController.greyColor,
            ),
          ],
        ),
      ],
    );
  }
}
