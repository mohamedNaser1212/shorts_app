import 'package:flutter/material.dart';
import 'package:shorts/core/widgets/custom_title.dart';

class EmailVerificationDialogueWidget extends StatelessWidget {
  const EmailVerificationDialogueWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const CustomTitle(
        title: 'Email Change Confirmation',
        style: TitleStyle.style16,
      ),
      content: const CustomTitle(
        title:
            'You have changed your email. To use this new email, you must authenticate it. Do you want to proceed with updating the email?',
        style: TitleStyle.style14,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const CustomTitle(
            title: 'Cancel',
            style: TitleStyle.style14,
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const CustomTitle(
            title: 'Update Email',
            style: TitleStyle.style14,
          ),
        ),
      ],
    );
  }
}
