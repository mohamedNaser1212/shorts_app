import 'package:flutter/material.dart';

import 'color_manager.dart';

abstract class StylesManager {
  const StylesManager._();
  static const textStyle12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    fontFamily: 'Inter',
  );
  static const textStyle14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontFamily: 'Inter',
  );
  static const textStyle14Bold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: 'Inter',
  );

  static const textStyle16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'Inter',
  );
  static const textStyle16Bold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: 'Inter',
  );

  static const textStyle18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: 'Inter',
  );
  static const textStyleBold18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: 'Inter',
  );
  static const textStyle20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: 'Inter',
  );
  static const textStyleBold20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: 'Inter',
  );
  static const textStyle22 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    fontFamily: 'Inter',
  );
  static const textStyleBold22 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    fontFamily: 'Inter',
  );
  static const textStyle24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    fontFamily: 'Inter',
    color: ColorController.whiteColor,
    letterSpacing: 1.2,
  );
  static const textStyleBold24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: 'Inter',
    color: ColorController.whiteColor,
    letterSpacing: 1.2,
  );
  static const textStyle30 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w900,
    fontFamily: 'Inter',
    color: ColorController.whiteColor,
    letterSpacing: 1.2,
  );
  static const style30Bold = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    fontFamily: 'Inter',
    color: ColorController.whiteColor,
    letterSpacing: 1.2,
  );
}
