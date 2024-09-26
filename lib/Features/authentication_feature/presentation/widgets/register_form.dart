import 'package:flutter/widgets.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/password_text_field.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/phone_text_field.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_screen_body.dart';

import 'email_text_field.dart';
import 'name_text_field.dart';

class RgisterForm extends StatelessWidget {
  const RgisterForm({
    super.key,
    required this.requestModel,
  });

  final RegisterScreenBodyState requestModel;

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Column _body() {
    return Column(
      children: [
        EmailField(controller: requestModel.emailController),
        const SizedBox(height: 15),
        PasswordField(
          controller: requestModel.passwordController,
        ),
        const SizedBox(height: 10),
        NameField(controller: requestModel.nameController),
        const SizedBox(height: 10),
        PhoneField(controller: requestModel.phoneController),
      ],
    );
  }
}
