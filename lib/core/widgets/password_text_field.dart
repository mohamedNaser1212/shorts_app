import 'package:flutter/material.dart';

import '../managers/field_validaltor/fields_validator.dart';
import '../utils/constants/consts.dart';
import 'reusable_text_form_field.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({
    super.key,
    required this.controller,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      label: 'Password',
      validator: FieldsValidator.isNotEmpty,
      controller: widget.controller,
      obscure: obscure,
      keyboardType: TextInputType.visiblePassword,
      activeColor: defaultLightColor,
      prefix: const Icon(Icons.lock),
      suffix: IconButton(
        onPressed: _onPressed,
        icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
      ),
    );
  }

  void _onPressed() {
    obscure = !obscure;
    setState(() {});
  }
}
