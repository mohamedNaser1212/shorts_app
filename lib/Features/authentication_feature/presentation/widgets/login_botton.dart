import 'package:flutter/material.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/login_screen_body.dart';

import '../../../../core/widgets/custom_elevated_botton.dart';


class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.state,
  });
  final LoginScreenBodyState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButton.loginButton(
          state: state,
          context: context,
        ),
      ],
    );
  }
}
