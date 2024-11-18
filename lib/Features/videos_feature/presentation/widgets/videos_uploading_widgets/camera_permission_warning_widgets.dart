import 'package:flutter/material.dart';

import '../../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../../core/widgets/custom_title.dart';
import 'go_to_settings_elevated_button.dart';

class CameraPermissionWarningWidgets extends StatelessWidget {
  const CameraPermissionWarningWidgets({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTitle(
          title: title,
          style: TitleStyle.style16,
          color: ColorController.whiteColor,
        ),
        const SizedBox(height: 20),
        const GoToSettingsElevatedButton(),
      ],
    );
  }
}
