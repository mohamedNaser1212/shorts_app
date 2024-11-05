import 'package:flutter/material.dart';

import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title.dart';

class AuthStatusTextWidget extends StatelessWidget {
  const AuthStatusTextWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CustomTitle(
        title: title,
        style: TitleStyle.style18,
        color: ColorController.purpleColor,
      ),
    );
  }
}
