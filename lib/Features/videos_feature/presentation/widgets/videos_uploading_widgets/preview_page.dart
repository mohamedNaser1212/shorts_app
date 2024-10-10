import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/preview_page_body.dart';


import '../../../../../core/widgets/custom_app_bar.dart';

// ignore: must_be_immutable
class PreviewPage extends StatefulWidget {
  PreviewPage({super.key, required this.outputPath, this.thumbnailFile});

  late String outputPath;
  final File? thumbnailFile;

  @override
  State<PreviewPage> createState() => PreviewPageState();
}

class PreviewPageState extends State<PreviewPage> {
 // late VideoPlayerController controller;
  final TextEditingController descriptionController = TextEditingController();

 
  @override
  void dispose() {
    // controller.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Preview',
      ),
      body: PreviewPageBody(
        previewState: this,
        thumbnailFile: widget.thumbnailFile,
      ),
    );
  }
}
