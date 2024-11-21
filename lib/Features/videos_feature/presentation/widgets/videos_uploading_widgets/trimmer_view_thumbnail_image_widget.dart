import 'dart:io';

import 'package:flutter/material.dart';

class TrimmerViewImageWidget extends StatelessWidget {
  const TrimmerViewImageWidget({
    super.key,
    required this.thumbnailFile,
  });

  final File? thumbnailFile;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          if (thumbnailFile != null && thumbnailFile!.existsSync())
            Image.file(thumbnailFile!, width: 200, height: 300)
          else
            const Text(
              "Thumbnail not available",
              style: TextStyle(color: Colors.grey),
            ),
        ],
      ),
    );
  }
}
