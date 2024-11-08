import 'package:flutter/material.dart';

import '../managers/field_validaltor/fields_validator.dart';
import '../managers/styles_manager/color_manager.dart';
import 'reusable_text_form_field.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  const PhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      label: 'Phone Number',
      validator: FieldsValidator.isValidPhoneNumber,
      controller: controller,
      keyboardType: TextInputType.phone,
      activeColor: ColorController.purpleColor,
      prefix: const Icon(Icons.phone),
    );
  }
}
