import 'package:flutter/material.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_screen_form.dart';

import '../../../../core/widgets/custom_elevated_botton.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
    required this.state,
  });

  final RegisterScreenFormState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButton.registerButton(
          context: context,
          state: state,
        ),
      ],
    );
  }
}
