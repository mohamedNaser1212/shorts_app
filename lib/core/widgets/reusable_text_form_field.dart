import 'package:flutter/material.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final double borderRadius;
  final Color activeColor;
  // final void Function() onTap;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSubmit;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Icon? prefix;
  final IconButton? suffix;
  final bool obscure;

  const CustomTextFormField({
    super.key,
    required this.label,
    this.borderRadius = 25,
    this.activeColor = ColorController.blueAccent,
    // required this.onTap,
    this.validator,
    this.onSubmit,
    required this.controller,
    required this.keyboardType,
    this.prefix,
    this.suffix,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        // onTap: onTap,
        validator: validator,
        onFieldSubmitted: onSubmit,
        decoration: InputDecoration(
          suffixIcon: suffix,
          prefixIcon: prefix,
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(width: 2.0, color: ColorController.greyColor),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          labelText: label,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: activeColor, width: 2.0),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
