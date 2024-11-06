import 'package:flutter/material.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/utils/constants/consts.dart';
import 'package:shorts/core/widgets/custom_title.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final String? hintText;
  final double borderRadius;
  final Color activeColor;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSubmit;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Icon? prefix;
  final IconButton? suffix;
  final bool obscure;
  final bool isCharacterCountEnabled; // Optional character count feature

  const CustomTextFormField({
    super.key,
    required this.label,
    this.borderRadius = 25,
    this.activeColor = ColorController.purpleColor,
    this.validator,
    this.onSubmit,
    required this.controller,
    required this.keyboardType,
    this.prefix,
    this.suffix,
    this.obscure = false,
    this.hintText,
    this.isCharacterCountEnabled = false, // Default is false
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late ValueNotifier<int> _characterCountNotifier;

  @override
  void initState() {
    super.initState();
    _characterCountNotifier = ValueNotifier<int>(widget.controller.text.length);
    widget.controller.addListener(_updateCharacterCount);
  }

  void _updateCharacterCount() {
    _characterCountNotifier.value = widget.controller.text.length;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateCharacterCount);
    _characterCountNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.controller,
            obscureText: widget.obscure,
            keyboardType: widget.keyboardType,
            maxLength: widget.isCharacterCountEnabled ? 20 : null,
            style: TextStyle(
              color: ColorController.whiteColor,
              fontSize: 16,
              fontFamily: constFontFamily,
            ),
            validator: widget.validator,
            onFieldSubmitted: widget.onSubmit,
            decoration: InputDecoration(
              counterText: '', // Hides default max length indicator
              suffixIcon: widget.suffix,
              prefixIcon: widget.prefix,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: ColorController.whiteColor,
                fontSize: 16,
                fontFamily: constFontFamily,
              ),
              prefixIconColor: ColorController.whiteColor,
              suffixIconColor: ColorController.whiteColor,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 2.0, color: ColorController.whiteColor),
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius)),
              ),
              labelText: widget.label,
              labelStyle: TextStyle(
                color: ColorController.whiteColor,
                fontSize: 16,
                fontFamily: constFontFamily,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: ColorController.purpleColor, width: 2.0),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
            ),
          ),
          if (widget.isCharacterCountEnabled)
            ValueListenableBuilder<int>(
              valueListenable: _characterCountNotifier,
              builder: (context, count, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomTitle(
                        title: '$count/20 ',
                        style: TitleStyle.style14,
                        color: ColorController.whiteColor,
                      ),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
