import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_title.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitle(
          title: 'Login Screen',
          style: TitleStyle.style14,
        ),
        CustomTitle(
          title: 'login now to browse our hot offers',
          style: TitleStyle.style16,
        ),
      ],
    );
  }
}
