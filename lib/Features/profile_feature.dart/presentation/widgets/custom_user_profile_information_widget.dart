import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_title.dart';

class CustomUserProfileInformations extends StatelessWidget {
  const CustomUserProfileInformations({
    super.key,
    required this.number,
    required this.title,
  });

  final int number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTitle(
          title: number.toString(),
          style: TitleStyle.style14Bold,
        ),
        CustomTitle(
          title: title,
          style: TitleStyle.style14,
        ),
      ],
    );
  }
}
