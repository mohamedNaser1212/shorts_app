import 'package:flutter/material.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/password_text_field.dart';

import '../screens/login_screen.dart';
import 'auth_status_text_widget.dart';
import 'email_text_field.dart';
import 'login_botton.dart';
import 'login_header.dart';

class LoginScreenBody extends StatelessWidget {
  final LoginScreenState state;

  const LoginScreenBody({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Center _body(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: state.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoginHeader(),
                const SizedBox(height: 30),
                EmailField(controller: state.emailController),
                const SizedBox(height: 15),
                PasswordField(
                  controller: state.passwordController,
                ),
                const SizedBox(height: 30),
                LoginButton(state: state),
                AuthStatusTextWidget.login(context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
