import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';

class CustomReadMoreWidget extends StatelessWidget {
  const CustomReadMoreWidget({
    super.key,
    required this.text,
    this.trimLines = 2,
    this.style,
    this.moreStyle,
    this.lessStyle,
  });

  final String text;
  final int trimLines;
  final TextStyle? style;
  final TextStyle? moreStyle;
  final TextStyle? lessStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ReadMoreText(
        text,
        trimLines: trimLines,
        trimMode: TrimMode.Line,
        trimCollapsedText: 'Show more',
        trimExpandedText: 'Show less',
        style: style ?? const TextStyle(fontSize: 14),
        moreStyle: moreStyle ?? const TextStyle(color: ColorController.blueAccent),
        lessStyle: lessStyle ?? const TextStyle(color: ColorController.blueAccent),
      ),
    );
  }
}
