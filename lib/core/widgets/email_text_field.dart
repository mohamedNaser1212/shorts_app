import 'package:flutter/material.dart';

import '../utils/constants/consts.dart';
import '../managers/field_validaltor/fields_validator.dart';
import 'reusable_text_form_field.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  const EmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      label: 'Email',
      validator: FieldsValidator.isValidEmail,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      activeColor: defaultLightColor,
      prefix: const Icon(Icons.email_rounded),
    );
  }
}
