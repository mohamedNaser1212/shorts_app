import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_elevated_botton.dart';
import '../screens/login_screen.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.state,
  });
  final LoginScreenState state;

  @override
  Widget build(BuildContext context) {
    return _LoginButton(state: state);
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    required this.state,
  });

  final LoginScreenState state;

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
