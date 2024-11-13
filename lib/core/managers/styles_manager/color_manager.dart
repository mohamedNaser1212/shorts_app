import 'package:flutter/material.dart';

abstract class ColorController {
  const ColorController._();
  // Primary Colors
  static const Color primaryColor = Colors.orange;
  static const Color accentColor = Colors.orangeAccent;
  static const Color transparentColor = Colors.transparent;
  static const Color purpleColor = Color(0xff7C4DFF);

  // Additional Colors
  static const Color blueAccentColor = Colors.blueAccent;
  static const Color redColor = Colors.red;

  // Neutral Colors
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;

  // Text Colors
  static const Color textColorPrimary = blackColor;
  static const Color greyColor = Colors.grey;

  // Background Colors
  static const Color backgroundColor = whiteColor;
  static const Color scaffoldBackgroundColor = whiteColor;

  // Button Colors
  static const Color buttonColor = primaryColor;
  static const Color buttonTextColor = whiteColor;

  // Icon Colors
  static const Color iconColor = blackColor;

  // Divider Colors
  static const Color dividerColor = Colors.grey;

  // Alert Colors
  static const Color warningColor = Colors.deepOrange;
  static const Color errorColor = Colors.redAccent;

  // Additional Colors for special use
  static const Color blueAccent = blueAccentColor;
  static const Color redAccent = redColor;
  static const Color greenColor = Colors.green;
}
