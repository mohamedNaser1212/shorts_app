import 'package:flutter/material.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_title.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  Color? color;
  Color? iconColor;

  CustomAppBar({
    super.key,
    required this.title,
    this.color,
  }) {
    color = color ?? ColorController.blueAccent;
    iconColor = iconColor ?? ColorController.whiteColor;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: iconColor,
        ),
        onPressed: () => _onPressed(context: context),
      ),
      title: CustomTitle(
        title: title,
        style: TitleStyle.styleBold20,
        color: ColorController.whiteColor,
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
