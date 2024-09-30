import 'package:flutter/material.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_screen_body.dart';

import '../../../../core/utils/widgets/custom_elevated_botton.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
    required this.state,
  });

  final RegisterScreenBodyState state;

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
