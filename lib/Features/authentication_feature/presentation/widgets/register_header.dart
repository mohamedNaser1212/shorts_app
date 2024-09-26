import 'package:flutter/material.dart';

import '../../../../core/utils/widgets/custom_title.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomTitle(
      title: 'REGISTER Screen',
      style: TitleStyle.styleBold20,
    );
  }
}
