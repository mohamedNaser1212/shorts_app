import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/trimmer_view.dart';
import 'package:shorts/core/widgets/custom_elevated_botton.dart';

class ChooseVideoPageElevatedButton extends StatefulWidget {
  const ChooseVideoPageElevatedButton({
    super.key,
  });

  @override
  State<ChooseVideoPageElevatedButton> createState() =>
      _ChooseVideoPageElevatedButtonState();
}

class _ChooseVideoPageElevatedButtonState
    extends State<ChooseVideoPageElevatedButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VideoCubit, VideoState>(
      listener: (context, state) {
        if (state is VideoPickedSuccess) {
          // Hide loading indicator when video is picked successfully
          setState(() {
            _isLoading = false;
          });

          // Navigate to TrimmerView page when video is picked
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TrimmerView(file: state.file),
            ),
          );
        } else if (state is VideoPickedLoading) {
          // Show loading indicator while picking video
          setState(() {
            _isLoading = true;
          });
        } else if (state is VideoPickedError) {
          // Hide loading indicator and show error message
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error picking video: ${state.message}')),
          );
        }
      },
      child: _isLoading
          ? const CircularProgressIndicator() // Show circular progress indicator when loading
          : CustomElevatedButton.chooseVideoPageButton(
              context: context,
              onPressed: () => _handleChooseVideo(context),
            ),
    );
  }

  Future<void> _handleChooseVideo(BuildContext context) async {
    // Call the cubit to handle video picking
    await VideoCubit.get(context).pickVideo();
  }
}
