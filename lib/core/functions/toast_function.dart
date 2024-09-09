import 'package:fluttertoast/fluttertoast.dart';
import 'package:shorts/core/utils/styles_manager/color_manager.dart';

void showToast({
  required String message,
  required bool isError,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    fontAsset: 'assets/fonts/Inter_24pt-Medium.ttf',
    backgroundColor:
        isError ? ColorController.redColor : ColorController.greenAccent,
    textColor: ColorController.whiteColor,
    fontSize: 16.0,
  );
}
