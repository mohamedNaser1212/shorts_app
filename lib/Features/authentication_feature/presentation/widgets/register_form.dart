import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_screen_form.dart';
import 'package:shorts/core/widgets/bio_text_form.dart';
import 'package:shorts/core/widgets/password_text_field.dart';
import 'package:shorts/core/widgets/phone_text_field.dart';

import '../../../../core/widgets/email_text_field.dart';
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
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: state.imageFile != null
                ? FileImage(File(state.imageFile!.path))
                : null,
            child: state.imageFile == null
                ? const Icon(Icons.person, size: 50)
                : null,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed:
              state.pickImage,
          child: const Text('Pick Image'),
        ),
        const SizedBox(height: 20),
        EmailField(controller: state.emailController),
        const SizedBox(height: 15),
        PasswordField(controller: state.passwordController),
        const SizedBox(height: 10),
        NameField(controller: state.nameController),
        const SizedBox(height: 10),
        PhoneField(controller: state.phoneController),
        const SizedBox(height: 10),
        BioField(controller: state.bioController),
      ],
    );
  }
}
