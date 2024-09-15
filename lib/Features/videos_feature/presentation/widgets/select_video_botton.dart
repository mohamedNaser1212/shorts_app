import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/core/utils/widgets/custom_title.dart';

import '../../../videos_feature/presentation/video_cubit/video_cubit.dart';

class SelectVideoButton extends StatelessWidget {
  final Function(String?) onVideoSelected;

  const SelectVideoButton({Key? key, required this.onVideoSelected})
      : super(key: key);

  Future<void> _pickVideo(BuildContext context) async {
    final result = await context.read<VideoCubit>().pickVideo();
    onVideoSelected(result);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _pickVideo(context),
      child: const CustomTitle(
        title: 'Select Video',
        style: TitleStyle.style18,
      ),
    );
  }
}
