import 'package:flutter/material.dart';

import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title.dart';

class ORTextWidget extends StatelessWidget {
  const ORTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: ColorController.whiteColor,
          ),
        ),
        SizedBox(width: 10),
        CustomTitle(
          title: 'OR',
          style: TitleStyle.style18,
          color: ColorController.whiteColor,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Divider(
            color: ColorController.whiteColor,
          ),
        ),
      ],
    );
  }
}
