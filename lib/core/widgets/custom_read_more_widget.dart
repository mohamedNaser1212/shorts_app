import 'package:flutter/material.dart';
import 'package:rich_readmore/rich_readmore.dart';

class CustomReadMoreWidget extends StatefulWidget {
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
  State<CustomReadMoreWidget> createState() => _CustomReadMoreWidgetState();
}

class _CustomReadMoreWidgetState extends State<CustomReadMoreWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      transform: Matrix4.translationValues(
          0, _isExpanded ? -20 : 0, 0), // Translate upward
      child: Column(
        children: [
          RichReadMoreText.fromString(
            text: widget.text,
            settings: LineModeSettings(
              trimLines: widget.trimLines,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              moreStyle:
                  widget.moreStyle ?? const TextStyle(color: Colors.blue),
              lessStyle:
                  widget.lessStyle ?? const TextStyle(color: Colors.blue),
              onPressReadMore: () {
                setState(() {
                  _isExpanded = true;
                });
              },
              onPressReadLess: () {
                setState(() {
                  _isExpanded = false;
                });
              },
            ),
            textStyle: widget.style ??
                const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
