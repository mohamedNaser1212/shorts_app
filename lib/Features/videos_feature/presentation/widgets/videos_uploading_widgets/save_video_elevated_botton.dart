import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/preview_page.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/trimmer_view_body.dart';
import 'package:shorts/core/functions/navigations_functions.dart';

class SaveElevatedButton extends StatefulWidget {
  const SaveElevatedButton({
    super.key,
    required this.state,
    this.thumbnailFile,
  });

  final TrimmerViewBodyState state;
  final File? thumbnailFile;

  @override
  State<SaveElevatedButton> createState() => _SaveElevatedButtonState();
}

class _SaveElevatedButtonState extends State<SaveElevatedButton> {
  late final ValueNotifier<bool> _progressVisibilityNotifier;

  @override
  void initState() {
    super.initState();
    _progressVisibilityNotifier =
        ValueNotifier<bool>(widget.state.progressVisibility);
  }

  @override
  void dispose() {
    _progressVisibilityNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _progressVisibilityNotifier,
      builder: (context, isVisible, child) {
        return ElevatedButton(
          onPressed: isVisible
              ? null
              : () async {
                  await _saveVideo();
                },
          child: const Text('Save Video'),
        );
      },
    );
  }

  Future<void> _saveVideo() async {
    _progressVisibilityNotifier.value = true;

    widget.state.trimmer.saveTrimmedVideo(
      startValue: widget.state.startValue,
      endValue: widget.state.endValue,
      onSave: (outputPath) async {
        _progressVisibilityNotifier.value = false;

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
