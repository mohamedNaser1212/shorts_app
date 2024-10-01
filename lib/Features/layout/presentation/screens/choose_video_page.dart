import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/layout/presentation/widgets/choose_video_page_body.dart';

import '../../../videos_feature/presentation/video_cubit/video_cubit.dart';

class ChooseVideoPage extends StatefulWidget {
  const ChooseVideoPage({super.key});

  @override
  State<ChooseVideoPage> createState() => ChooseVideoPageState();
}

class ChooseVideoPageState extends State<ChooseVideoPage> {
  final TextEditingController titleController = TextEditingController();
  String? selectedVideoPath;

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoCubit, VideoState>(
      listener: _listener,
      builder: (context, state) {
        if (state is VideoSelected) {
          selectedVideoPath = state.videoPath; 
        }
        return ChooseVideoPageBody(
          state: this,
          selectedVideoPath: selectedVideoPath, 
        );
      },
    );
  }

  void _listener(BuildContext context, VideoState state) {
    if (state is VideoUploadErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${state.message}')),
      );
    } else if (state is VideoUploadedSuccessState) {
      titleController.clear();
      setState(() {
        selectedVideoPath = null; 
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Video uploaded successfully!')),
      );
    }
  }
}
