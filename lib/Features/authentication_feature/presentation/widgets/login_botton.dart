import 'package:flutter/material.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/login_screen_body.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';

import '../../../../core/widgets/reusable_elevated_botton.dart';
import '../../data/user_model/login_request_model.dart';
import '../cubit/login_cubit/login_cubit.dart';

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
        ReusableElevatedButton(
          onPressed: () => _loginAction(state, context),
          label: 'Sign In',
          backColor: ColorController.purpleColor,
        ),
        // CustomElevatedButton.loginButton(
        //   state: state,
        //   context: context,
        //
        //
        // ),
      ],
    );
  }

  static void _loginAction(LoginScreenBodyState state, BuildContext context) {
    if (state.formKey.currentState!.validate()) {
      LoginCubit.get(context).login(
        requestModel: LoginRequestModel(
          email: state.emailController.text,
          password: state.passwordController.text,
        ),
      );
    }
  }
}
