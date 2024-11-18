import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/widgets/reusable_elevated_botton.dart';

class GoToSettingsElevatedButton extends StatelessWidget {
  const GoToSettingsElevatedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: ReusableElevatedButton(
        onPressed: () {
          openAppSettings();
        },
        label: "Go to Settings",
      ),
    );
  }
}
