import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

import '../utils/styles_manager/color_manager.dart';

void showToast({
  required String message,
  Color color = ColorController.redColor,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    fontAsset: 'assets/fonts/Inter_24pt-Medium.ttf',
    backgroundColor: color,
    textColor: ColorController.whiteColor,
    fontSize: 16.0,
  );
}
