import 'package:flutter/material.dart';
import 'package:shorts/core/widgets/custom_elevated_botton.dart';

class ChooseVideoPageElevatedBotton extends StatelessWidget {
  const ChooseVideoPageElevatedBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton.chooseVideoPageBotton(context: context);
  }
}
