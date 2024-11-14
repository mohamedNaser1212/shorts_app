import 'package:flutter/material.dart';
import 'package:shorts/core/managers/styles_manager/text_styles_manager.dart';
import 'package:shorts/core/utils/constants/consts.dart';

import '../managers/styles_manager/color_manager.dart';

enum TitleStyle {
  style12,
  style14,
  style14Bold,
  style16,
  style16Bold,
  style18,
  styleBold18,
  style20,
  styleBold20,
  style22,
  styleBold22,
  style24,
  styleBold24,
  style30,
  style30Bold
}

class CustomTitle extends StatelessWidget {
  final String title;
  final TitleStyle style;
  final Color? color;
  final int? maxLines;
  final TextOverflow overflow;
  final double? wordSpacing;
  final TextAlign? textAlign;

  const CustomTitle({
    required this.title,
    required this.style,
    this.color = ColorController.whiteColor,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.wordSpacing,
    this.textAlign,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle;
    switch (style) {
      case TitleStyle.style14:
        textStyle = StylesManager.textStyle14.copyWith(
          color: color,
          fontFamily: constFontFamily,
          wordSpacing: wordSpacing,
        );
        break;
      case TitleStyle.style14Bold:
        textStyle = StylesManager.textStyle14Bold.copyWith(
          color: color,
          fontFamily: constFontFamily,
          wordSpacing: wordSpacing,
        );
        break;
      case TitleStyle.style12:
        textStyle = StylesManager.textStyle12.copyWith(
          color: color,
          fontFamily: constFontFamily,
          wordSpacing: wordSpacing,
        );
        break;
      case TitleStyle.style16:
        textStyle = StylesManager.textStyle16.copyWith(
          color: color,
          fontFamily: constFontFamily,
          wordSpacing: wordSpacing,
        );
        break;
      case TitleStyle.style16Bold:
        textStyle = StylesManager.textStyle16Bold.copyWith(
          color: color,
          fontFamily: constFontFamily,
          wordSpacing: wordSpacing,
        );
        break;
      case TitleStyle.style18:
        textStyle = StylesManager.textStyle18.copyWith(
          color: color,
          fontFamily: constFontFamily,
          wordSpacing: wordSpacing,
        );
        break;
      case TitleStyle.styleBold18:
        textStyle = StylesManager.textStyleBold18.copyWith(
          color: color,
          fontFamily: constFontFamily,
          wordSpacing: wordSpacing,
        );
        break;
      case TitleStyle.style20:
        textStyle = StylesManager.textStyle20.copyWith(
          color: color,
          fontFamily: constFontFamily,
          wordSpacing: wordSpacing,
        );
        break;
      case TitleStyle.styleBold20:
        textStyle = StylesManager.textStyleBold22.copyWith(
          color: color,
          fontFamily: constFontFamily,
          wordSpacing: wordSpacing,
        );
        break;
      case TitleStyle.style22:
        textStyle = StylesManager.textStyle20.copyWith(
          color: color,
          fontFamily: constFontFamily,
          wordSpacing: wordSpacing,
        );
        break;
      case TitleStyle.styleBold22:
        textStyle = StylesManager.textStyleBold22.copyWith(
          color: color,
          fontFamily: constFontFamily,
          wordSpacing: wordSpacing,
        );
        break;
      case TitleStyle.style24:
        textStyle = StylesManager.textStyle24.copyWith(
          color: color,
          fontFamily: constFontFamily,
          wordSpacing: wordSpacing,
        );
        break;
      case TitleStyle.styleBold24:
        textStyle = StylesManager.textStyleBold24.copyWith(
          color: color,
          fontFamily: constFontFamily,
          wordSpacing: wordSpacing,
        );
        break;
      case TitleStyle.style30:
        textStyle = StylesManager.textStyle30.copyWith(
          color: color,
          fontFamily: constFontFamily,
          wordSpacing: wordSpacing,
        );
        break;
      case TitleStyle.style30Bold:
        textStyle = StylesManager.style30Bold.copyWith(
          color: color,
          fontFamily: constFontFamily,
          wordSpacing: wordSpacing,
        );
        break;
    }

    return Text(
      title,
      style: textStyle,
      maxLines: maxLines,
      overflow: maxLines == null ? TextOverflow.visible : overflow,
      textAlign: textAlign,
    );
  }
}
