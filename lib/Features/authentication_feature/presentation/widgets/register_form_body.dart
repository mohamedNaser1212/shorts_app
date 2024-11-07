import 'package:flutter/material.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_screen_form.dart';
import 'package:shorts/core/widgets/password_text_field.dart';

import '../../../../core/widgets/email_text_field.dart';
import '../../../profile_feature.dart/presentation/widgets/edit_user_profile_image_widget.dart';
import 'name_text_field.dart';

class RegisterFormBody extends StatelessWidget {
  final RegisterScreenFormState state;

  const RegisterFormBody({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        EditUserProfileImageWidget(
          registerFormState: state,
        ),
        const SizedBox(height: 10),
        // ElevatedButton(
        //   onPressed: state.imageNotifierController.pickImage,
        //   child:
        //       const CustomTitle(title: 'Pick Image', style: TitleStyle.style14),
        // ),
        NameField(controller: state.nameController),

        const SizedBox(height: 10),
        EmailField(controller: state.emailController),
        const SizedBox(height: 15),
        PasswordField(controller: state.passwordController),
        const SizedBox(height: 10),
        // const SizedBox(height: 10),
        // PhoneField(controller: state.phoneController),
        // const SizedBox(height: 10),
        // BioField(controller: state.bioController),
      ],
    );
  }
}
