import 'package:flutter/widgets.dart';
import 'package:shorts/core/widgets/password_text_field.dart';
import 'package:shorts/core/widgets/phone_text_field.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_screen_form.dart';

import '../../../../core/widgets/email_text_field.dart';
import 'name_text_field.dart';

class RgisterFormBody extends StatelessWidget {
  const RgisterFormBody({
    super.key,
    required this.requestModel,
  });

  final RegisterScreenFormState requestModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmailField(controller: requestModel.emailController),
        const SizedBox(height: 15),
        PasswordField(controller: requestModel.passwordController),
        const SizedBox(height: 10),
        NameField(controller: requestModel.nameController),
        const SizedBox(height: 10),
        PhoneField(controller: requestModel.phoneController),
      ],
    );
  }
}
