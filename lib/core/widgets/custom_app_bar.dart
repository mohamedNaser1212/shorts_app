import 'package:flutter/material.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_title.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLeadingIcon;
  final Color? backColor;
  final Color? textColor;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final TitleStyle? titleStyle;
  final double? leadingSize;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showLeadingIcon = true,
    this.backColor = ColorController.blueAccent,
    this.textColor = ColorController.whiteColor,
    this.actions,
    this.centerTitle = false,
    this.leading,
    this.titleStyle,
    this.leadingSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backColor,
      leading: leading ??
          (showLeadingIcon
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: ColorController.whiteColor,
                    size: leadingSize,
                  ),
                  onPressed: () => _onPressed(context: context),
                )
              : null),
      title: CustomTitle(
        title: title,
        style: titleStyle ?? TitleStyle.styleBold20,
        color: textColor ?? ColorController.whiteColor,
      ),
      centerTitle: centerTitle,
      actions: actions,
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
