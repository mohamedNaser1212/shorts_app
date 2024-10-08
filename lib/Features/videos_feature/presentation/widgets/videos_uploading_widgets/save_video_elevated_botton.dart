import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/preview_page.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/trimmer_view_body.dart';
import 'package:shorts/core/functions/navigations_functions.dart';

class SaveElevatedBotton extends StatefulWidget {
  const SaveElevatedBotton({
    super.key,
    required this.state,
    this.thumbnailFile,
  });

  final TrimmerViewBodyState state;
  final File? thumbnailFile;

  @override
  State<SaveElevatedBotton> createState() => _SaveElevatedBottonState();
}

class _SaveElevatedBottonState extends State<SaveElevatedBotton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.state.progressVisibility
          ? null
          : () async {
              await _saveVideo();
            },
      child: const Text('Save Video'),
    );
  }

  Future<void> _saveVideo() async {
    setState(() {
      widget.state.progressVisibility = true;
    });

    widget.state.trimmer.saveTrimmedVideo(
      startValue: widget.state.startValue,
      endValue: widget.state.endValue,
      onSave: (outputPath) async {
        setState(() {
          widget.state.progressVisibility = false;
        });

        await widget.state.generateThumbnail(
          widget.state.startValue,
          outputPath!,
        );
        NavigationManager.navigateAndFinish(
          context: context,
          screen: PreviewPage(
            outputPath: outputPath,
            thumbnailFile: widget.state.thumbnailFile,
          ),
        );
      },
    );
  }
}
