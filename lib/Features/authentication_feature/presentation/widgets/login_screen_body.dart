import 'package:flutter/material.dart';
import 'package:shorts/core/widgets/password_text_field.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/widgets/email_text_field.dart';
import '../screens/register_screen.dart';
import 'check_user_status_text_widget.dart';
import 'google_sign_in_widget.dart';
import 'login_botton.dart';
import 'login_header.dart';
import 'or_text_widget.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({
    super.key,
  });

  @override
  State<LoginScreenBody> createState() => LoginScreenBodyState();
}

class LoginScreenBodyState extends State<LoginScreenBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AuthHeader(
                  title: 'Sign In Now',
                ),
                const SizedBox(height: 70),

                EmailField(controller: emailController),
                const SizedBox(height: 15),
                PasswordField(
                  controller: passwordController,
                ),
                const SizedBox(height: 30),
                LoginButton(state: this),
                const SizedBox(height: 30),
                AuthStatusTextWidget(
                  title: 'Don\'t Have An Account?',
                  onTap: () {
                    NavigationManager.navigateTo(
                      context: context,
                      screen: const RegisterScreen(),
                    );
                  },
                ),

                const SizedBox(height: 30),
                const ORTextWidget(),
                const SizedBox(height: 30),
                const GoogleSignInWidget()

                //AuthStatusTextWidget.login(context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
