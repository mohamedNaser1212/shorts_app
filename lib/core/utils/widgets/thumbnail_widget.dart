import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shorts/core/functions/navigations_manager.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../Features/videos_feature/presentation/widgets/thumbnail_page.dart';

class ThumbnailWidget extends StatefulWidget {
  const ThumbnailWidget({super.key, this.videoPath});
  final String? videoPath;

  @override
  State<ThumbnailWidget> createState() => _ThumbnailWidgetState();
}

class _ThumbnailWidgetState extends State<ThumbnailWidget> {
  String? _thumbnailPath;

  @override
  void initState() {
    super.initState();
    if (widget.videoPath != null) {
      _generateThumbnail(widget.videoPath!);
    }
  }

  Future<void> _generateThumbnail(String videoPath) async {
    final tempDir = await getTemporaryDirectory();
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      thumbnailPath: tempDir.path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 100,
      quality: 75,
    );

    setState(() {
      _thumbnailPath = thumbnailPath;
    });
  }

  void _navigateToThumbnailPage(BuildContext context) {
    if (widget.videoPath != null) {
      NavigationManager.navigateTo(
        context: context,
        screen: ThumbnailPage(videoPath: widget.videoPath!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _thumbnailPath != null
        ? GestureDetector(
            onTap: () => _navigateToThumbnailPage(context),
            child: Image.file(
              File(_thumbnailPath!),
              fit: BoxFit.cover,
              width: 150,
              height: 150,
            ),
          )
        : const SizedBox.shrink();
  }
}
