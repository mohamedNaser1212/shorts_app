import 'package:flutter/material.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/utils/constants/consts.dart';
import 'package:shorts/core/widgets/custom_title.dart';

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final double borderRadius;
  final Color activeColor;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSubmit;
  final String? Function(String?)? onChanged;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Icon? prefix;
  final IconButton? suffix;
  final bool obscure;
  final bool isCharacterCountEnabled;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final bool useWhiteBorder;
  final bool controllerBlackColor;
  final bool showBorder;
  final int? maxLength;
  const CustomTextFormField({
    super.key,
    this.label,
    this.onChanged,
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
    this.isCharacterCountEnabled = false,
    this.labelStyle,
    this.hintStyle,
    this.useWhiteBorder = false,
    this.controllerBlackColor = false,
    this.showBorder = true,
    this.maxLength,
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
    Color borderColor = widget.useWhiteBorder
        ? ColorController.whiteColor
        : ColorController.purpleColor;
    Color textColor =
        widget.controllerBlackColor ? Colors.black : ColorController.whiteColor;

    OutlineInputBorder border = OutlineInputBorder(
      borderSide: widget.showBorder
          ? BorderSide(width: 2.0, color: borderColor)
          : BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.controller,
            obscureText: widget.obscure,
            keyboardType: widget.keyboardType,
            maxLength: widget.maxLength,
            onChanged: widget.onChanged,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontFamily: constFontFamily,
            ),
            validator: widget.validator,
            onFieldSubmitted: widget.onSubmit,
            decoration: InputDecoration(
              counterText: '',
              suffixIcon: widget.suffix,
              prefixIcon: widget.prefix,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  TextStyle(
                    color: ColorController.whiteColor,
                    fontSize: 16,
                    fontFamily: constFontFamily,
                  ),
              prefixIconColor: ColorController.whiteColor,
              suffixIconColor: ColorController.whiteColor,
              enabledBorder: border,
              focusedBorder: border,
              labelText: widget.label,
              labelStyle: widget.labelStyle ??
                  TextStyle(
                    color: ColorController.whiteColor,
                    fontSize: 16,
                    fontFamily: constFontFamily,
                  ),
            ),
          ),
          if (widget.isCharacterCountEnabled && widget.maxLength != null)
            ValueListenableBuilder<int>(
              valueListenable: _characterCountNotifier,
              builder: (context, count, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomTitle(
                        title: '$count/${widget.maxLength ?? 0}',
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
