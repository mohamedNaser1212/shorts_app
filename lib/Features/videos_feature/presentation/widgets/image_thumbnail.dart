import 'dart:io';

import 'package:flutter/material.dart';

class ImageThumbnail extends StatefulWidget {
  const ImageThumbnail({super.key, required this.thumbnailPath});
  final String? thumbnailPath;

  @override
  State<ImageThumbnail> createState() => _ImageThumbnailState();
}
class _ImageThumbnailState extends State<ImageThumbnail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Image.file(
        File(widget.thumbnailPath!),
        height: 100,
        width: 100,
      ),
    );
  }
}
