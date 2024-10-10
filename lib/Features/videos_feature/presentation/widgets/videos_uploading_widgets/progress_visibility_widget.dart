import 'package:flutter/material.dart';

class ProgressVisibilityWidget extends StatelessWidget {
  const ProgressVisibilityWidget({
    super.key,
    required this.progressVisibility,
  });

  final bool progressVisibility;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: progressVisibility,
      child: const LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
      ),
    );
  }
}
