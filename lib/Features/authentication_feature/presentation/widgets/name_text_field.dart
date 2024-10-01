import 'package:flutter/material.dart';

import '../../../../core/utils/constants/consts.dart';
import '../../../../core/managers/field_validaltor/fields_validator.dart';
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
      activeColor: defaultLightColor,
      prefix: const Icon(Icons.person),
    );
  }
}
