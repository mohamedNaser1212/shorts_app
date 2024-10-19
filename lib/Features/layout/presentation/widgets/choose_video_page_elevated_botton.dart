import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/trimmer_view.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/functions/toast_function.dart';
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
      listener: _listener,
      child: _isLoading
          ? const CircularProgressIndicator()
          : CustomElevatedButton.chooseVideoPageButton(
              context: context,
            ),
    );
  }

  void _listener(context, state) {
    if (state is VideoPickedSuccess) {
      setState(() {
        _isLoading = false;
      });

      NavigationManager.navigateTo(
        context: context,
        screen: TrimmerView(file: state.file),
      );
    } else if (state is VideoPickedLoading) {
      setState(() {
        _isLoading = true;
      });
    } else if (state is VideoPickedError) {
      setState(() {
        _isLoading = false;
      });
      ToastHelper.showToast(
        message: state.message,
      );
    }
  }
}
