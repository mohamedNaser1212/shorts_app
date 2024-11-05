import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title.dart';

class GoogleSignInWidget extends StatelessWidget {
  const GoogleSignInWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.07,
      decoration: BoxDecoration(
        color: ColorController.purpleColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.google,
            color: ColorController.whiteColor,
          ),
          SizedBox(width: 10),
          CustomTitle(
            title: 'Use Google Account',
            style: TitleStyle.styleBold20,
            color: ColorController.whiteColor,
          ),
        ],
      ),
    );
  }
}
