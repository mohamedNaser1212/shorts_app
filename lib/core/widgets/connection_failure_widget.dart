import 'package:flutter/material.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_title.dart';
import 'package:shorts/core/widgets/reusable_elevated_botton.dart';

class ConnectionFailureWidget extends StatelessWidget {
  const ConnectionFailureWidget({super.key, this.onPressed});
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(

          children: [
            const Icon(Icons.wifi_off, size: 80, color: ColorController.redColor,),
            const SizedBox(height: 20),
            const CustomTitle(
              title: 'No Internet Connection',
              style: TitleStyle.styleBold20,
            ),
            const SizedBox(height: 10),
            const CustomTitle(
              title: 'Please check your internet connection and try again',
              style: TitleStyle.style16,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child:
                  ReusableElevatedButton(label: 'Retry', onPressed: onPressed),
            )
          ],
        ),
      ),
    );
  }
}
