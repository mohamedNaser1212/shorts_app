import 'package:flutter/material.dart';
import 'package:shorts/core/widgets/custom_app_bar.dart';
import 'package:shorts/core/widgets/custom_icon_widget.dart';

import '../managers/styles_manager/color_manager.dart';
import 'custom_title.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorController.blackColor,
      appBar: CustomAppBar(
        title: 'Verify Account',
        titleStyle: TitleStyle.styleBold22,
        backColor: Colors.green,
        centerTitle: true,
        showLeadingIcon: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomIconWidget(
              icon: Icons.verified_user_rounded,
              color: ColorController.greenColor,
              size: 150,
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 40),
            //   child: Text(
            //     'Verification Link Sent to your Email, Please Check Your Email To Verify Your Account',
            //     style: TextStyle(
            //       fontSize: 20,
            //       wordSpacing: 2,
            //       color: ColorController.greenColor,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: CustomTitle(
                title:
                    'Verification Link Sent to your Email, Please Check Your Email To Verify Your Account',
                style: TitleStyle.style20,
                wordSpacing: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
