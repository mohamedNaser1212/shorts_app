import 'package:flutter/material.dart';

import '../../../../core/constants/consts.dart';
import '../../../../core/managers/field_validaltor/fields_validator.dart';
import '../../../../core/utils/widgets/reusable_text_form_field.dart';

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
      activeColor: defaultLightColor,
      prefix: const Icon(Icons.phone),
    );
  }
}
