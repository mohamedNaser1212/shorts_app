import 'package:flutter/material.dart';

import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_lottie_search_animation_widget.dart';
import '../../../../core/widgets/custom_title.dart';

class EmptyCommentsWidget extends StatelessWidget {
  const EmptyCommentsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomLottieSearchAnimationWidget(),
          SizedBox(height: 10),
          CustomTitle(
            title: 'There are no comments yet',
            style: TitleStyle.style16,
            color: ColorController.blackColor,
          ),
        ],
      ),
    );
  }
}
