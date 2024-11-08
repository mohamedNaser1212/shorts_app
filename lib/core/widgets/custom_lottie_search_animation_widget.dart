import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLottieSearchAnimationWidget extends StatelessWidget {
  const CustomLottieSearchAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lottie_files/lottieSearchAnimation.json',
      width: MediaQuery.sizeOf(context).width * 0.5,
    );
  }
}
