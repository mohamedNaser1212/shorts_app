import 'package:flutter/material.dart';

import '../managers/styles_manager/color_manager.dart';

class BlockInteractionLoadingWidget extends StatelessWidget {
  const BlockInteractionLoadingWidget({
    super.key,
    required this.isLoading,
    required this.child,
    this.color = ColorController.whiteColor,
  });

  final bool isLoading;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: ColorController.blackColor.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  color,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
