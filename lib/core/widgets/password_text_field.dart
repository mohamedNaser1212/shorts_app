import 'package:flutter/material.dart';

import '../utils/constants/consts.dart';
import '../managers/field_validaltor/fields_validator.dart';
import 'reusable_text_form_field.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure = true;

  const PasswordField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      label: 'Password',
      validator: FieldsValidator.isNotEmpty,
      controller: controller,
      obscure: obscure,
      keyboardType: TextInputType.visiblePassword,
      activeColor: defaultLightColor,
      prefix: const Icon(Icons.key_rounded),
      suffix: IconButton(
        onPressed: _onPressed,
        icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
      ),
    );
  }

  void _onPressed() {}
}
