import 'package:flutter/material.dart';
import 'package:shorts/core/widgets/custom_title.dart';

abstract class DialogueHelper {
  static void showLimitDialog({
    required BuildContext context,
    required String text,
    required int maxClickCount,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const CustomTitle(
          title: "Limit Exceeded",
          style: TitleStyle.style16,
        ),
        content: CustomTitle(
          title: "You can't use the $text action more than $maxClickCount times.",
          style: TitleStyle.style14,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const CustomTitle(
              title: "ok",
              style: TitleStyle.style14,
            ),
          ),
        ],
      ),
    );
  }
}

