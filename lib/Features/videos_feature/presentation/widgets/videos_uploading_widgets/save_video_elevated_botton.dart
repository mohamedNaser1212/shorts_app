import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/preview_screen.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/trimmer_view_body.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/widgets/custom_title.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: _progressVisibilityNotifier,
          builder: (context, isVisible, child) {
            return ElevatedButton(
              onPressed: isVisible
                  ? null
                  : () async {
                      await _saveVideo();
                    },
              child: isVisible
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        color: Colors.white,
                      ),
                    )
                  : const CustomTitle(
                      title: 'Save Video',
                      style: TitleStyle.style12,
                    ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Future<void> _saveVideo() async {
    _progressVisibilityNotifier.value = true;
    widget.state.trimmer.saveTrimmedVideo(
      startValue: widget.state.videoController.startValue,
      endValue: widget.state.videoController.endValue,
      onSave: (outputPath) async {
        _progressVisibilityNotifier.value = false;

        await widget.state.videoController.generateThumbnail(
          seconds: widget.state.videoController.startValue,
          videoPath: outputPath!,
        );
        if (!mounted) return;

        NavigationManager.navigateAndFinish(
          context: context,
          screen: PreviewScreen(
            outputPath: outputPath,
            thumbnailFile: widget.state.videoController.thumbnailFile,
          ),
        );
      },
    );
  }
}
