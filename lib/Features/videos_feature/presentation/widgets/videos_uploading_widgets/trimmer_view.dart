import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/trimmer_view_body.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_app_bar.dart';

class TrimmerView extends StatefulWidget {
  const TrimmerView({super.key, required this.file});

  final File file;

  @override
  State<TrimmerView> createState() => TrimmerViewState();
}

class TrimmerViewState extends State<TrimmerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorController.blackColor,
      appBar: const CustomAppBar(
        backColor: ColorController.transparentColor,
        title: 'Trim Video',
        centerTitle: true,
        showLeadingIcon: true,
      ),
      body: TrimmerViewBody(
        file: widget.file,
      ),
    );
  }
}
