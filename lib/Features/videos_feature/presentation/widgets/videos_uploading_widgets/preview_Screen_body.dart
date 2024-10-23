import 'dart:io';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/preview_screen.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/thumbnail_preview_widget.dart';
import 'package:shorts/core/widgets/custom_elevated_botton.dart';
import 'package:shorts/core/widgets/reusable_text_form_field.dart';

class PreviewScreeBody extends StatefulWidget {
  const PreviewScreeBody({
    super.key,
    required this.previewState,
    this.thumbnailFile,
  });
  final PreviewScreenState previewState;
  final File? thumbnailFile;

  @override
  State<PreviewScreeBody> createState() => _PreviewScreeBodyState();
}

class _PreviewScreeBodyState extends State<PreviewScreeBody> {
  late CachedVideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = CachedVideoPlayerController.file(File(
        widget.thumbnailFile?.path ?? widget.previewState.widget.outputPath),)
      ..initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ThumbnailPreviewWidget(controller: controller, widget: widget),
            const SizedBox(height: 10),
            CustomTextFormField(
              label: 'Video Description',
              controller: widget.previewState.descriptionController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            CustomElevatedButton.uploadVideo(
              context: context,
              previewState: widget.previewState,
              thumbnailFile: widget.thumbnailFile,
            ),
          ],
        ),
      ),
    );
  }
}
