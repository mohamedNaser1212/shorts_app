import 'package:flutter/material.dart';

import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_title.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLeadingIcon;
  final Color? backColor;
  final Color? textColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showLeadingIcon = true,
    this.backColor = ColorController.blueAccent,
    this.textColor = ColorController.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backColor,
      leading: showLeadingIcon
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: ColorController.whiteColor,
              ),
              onPressed: () => _onPressed(context: context),
            )
          : null,
      title: CustomTitle(
        title: title,
        style: TitleStyle.styleBold20,
        color: textColor,
      ),
    );
  }

  void _onPressed({
    required BuildContext context,
  }) {
    Navigator.pop(context);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
