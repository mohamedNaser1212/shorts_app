import 'package:flutter/material.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/auth_status_text_widget.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_botton.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_form.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_header.dart';

class RegisterScreenForm extends StatefulWidget {
  const RegisterScreenForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  State<RegisterScreenForm> createState() => RegisterScreenFormState();
}

class RegisterScreenFormState extends State<RegisterScreenForm> {
    late final TextEditingController emailController;
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const RegisterHeader(),
          const SizedBox(height: 15),
          RgisterFormBody(requestModel: this),
          const SizedBox(height: 10),
          RegisterButton(state: this),
          const SizedBox(height: 10),
          AuthStatusTextWidget.register(context: context),
        ],
      ),
    );
  }
}
