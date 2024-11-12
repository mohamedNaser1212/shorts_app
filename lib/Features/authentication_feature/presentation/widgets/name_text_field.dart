import 'package:flutter/material.dart';

import '../../../../core/managers/field_validaltor/fields_validator.dart';
import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/widgets/reusable_text_form_field.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;
  const NameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      label: 'User Name',
      validator: FieldsValidator.isValidUsername,
      controller: controller,
      keyboardType: TextInputType.text,
      maxLength: 20,
      activeColor: ColorController.purpleColor,
      prefix: const Icon(Icons.person),
      isCharacterCountEnabled: true,
    );
  }
}
