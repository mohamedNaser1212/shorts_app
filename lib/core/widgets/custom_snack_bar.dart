// custom_snack_bar.dart
import 'package:flutter/material.dart';
import 'package:shorts/core/widgets/custom_title.dart';

import '../managers/styles_manager/color_manager.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
  String? actionLabel,
  VoidCallback? onActionPressed,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      backgroundColor: ColorController.greenColor,
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      content: CustomTitle(
        title: message,
        style: TitleStyle.style12,
      ),
      action: actionLabel != null && onActionPressed != null
          ? SnackBarAction(
              label: actionLabel,
              onPressed: onActionPressed,
              textColor: ColorController.whiteColor,
            )
          : null,
    ),
  );
}
