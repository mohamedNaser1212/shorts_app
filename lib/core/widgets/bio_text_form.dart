import 'package:flutter/material.dart';

import '../utils/constants/consts.dart';
import '../managers/field_validaltor/fields_validator.dart';
import 'reusable_text_form_field.dart';

class BioField extends StatelessWidget {
  final TextEditingController controller;
  const BioField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      label: 'bio',
      validator: FieldsValidator.isNotEmpty,
      controller: controller,
      keyboardType: TextInputType.text,
      activeColor: defaultLightColor,
      prefix: const Icon(Icons.book_sharp),
    );
  }
}
