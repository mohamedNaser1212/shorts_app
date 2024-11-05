import 'package:flutter/material.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_title.dart';

class FollowTextWidget extends StatelessWidget {
  const FollowTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorController.whiteColor,
        ),
        color: Colors.transparent,
      ),
      child: const CustomTitle(
        title: "Follow",
        style: TitleStyle.style16,
        color: ColorController.whiteColor,
      ),
    );
  }
}
