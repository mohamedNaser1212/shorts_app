// custom_snack_bar.dart
import 'package:flutter/material.dart';

import '../managers/styles_manager/color_manager.dart';

void showMySnackBar({
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
      content: Text(
        message,
        style: const TextStyle(color: ColorController.whiteColor, fontSize: 16),
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
// class CustomSnackBar {
//   static SnackBar show({
//     required String message,
//     String? actionLabel,
//     VoidCallback? onActionPressed,
//   }) {
//     return SnackBar(
//       showCloseIcon: true,
//       backgroundColor: Colors.greenAccent,
//       dismissDirection: DismissDirection.up,
//       behavior: SnackBarBehavior.floating,
//       margin: const EdgeInsets.all(20),
//       padding: const EdgeInsets.all(10),
//       content: Text(
//         message,
//         style: const TextStyle(color: Colors.white, fontSize: 16),
//       ),
//       action: actionLabel != null && onActionPressed != null
//           ? SnackBarAction(
//               label: actionLabel,
//               onPressed: onActionPressed,
//               textColor: Colors.white,
//             )
//           : null,
//     );
//   }
// }
