import 'package:flutter/material.dart';
import 'package:shorts/core/widgets/custom_elevated_botton.dart';

class EditProfilePageElevatedButton extends StatelessWidget {
  const EditProfilePageElevatedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton.editProfilePage(
      context: context,
    );
  }
}
