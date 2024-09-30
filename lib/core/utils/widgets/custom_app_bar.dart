import 'package:flutter/material.dart';
import 'package:shorts/core/utils/styles_manager/color_manager.dart';
import 'package:shorts/core/utils/widgets/custom_title.dart';


// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  Color? color=ColorController.primaryColor;

  
   CustomAppBar({
    super.key,
    required this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
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
