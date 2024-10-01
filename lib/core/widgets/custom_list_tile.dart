import 'package:flutter/material.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_title.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? color;

  const CustomListTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.leading,
    this.trailing,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading ??
          const CircleAvatar(backgroundColor: ColorController.greyColor, radius: 20),
      title: CustomTitle(
        title: title,
        style: TitleStyle.style16Bold,
        color: color,
      ),
      subtitle: CustomTitle(
        title: subtitle,
        style: TitleStyle.style18,
        color: color,
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
