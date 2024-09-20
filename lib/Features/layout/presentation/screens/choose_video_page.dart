import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/utils/widgets/custom_title.dart';

import '../../../../core/utils/widgets/thumbnail_widget.dart';
import '../../../videos_feature/presentation/video_cubit/video_cubit.dart';
import '../../../videos_feature/presentation/widgets/select_video_botton.dart';

class ChooseVideoPage extends StatefulWidget {
  const ChooseVideoPage({super.key});

  @override
  State<ChooseVideoPage> createState() => _ChooseVideoPageState();
}

class _ChooseVideoPageState extends State<ChooseVideoPage> {
  final TextEditingController _titleController = TextEditingController();
  String? _selectedVideoPath;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _uploadVideo() async {
    final user = UserInfoCubit.get(context).userEntity;
    if (_selectedVideoPath != null || user != null) {
      await VideoCubit.get(context).uploadVideo(
        videoPath: _selectedVideoPath!,
        description: _titleController.text,
        user: UserInfoCubit.get(context).userEntity!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoCubit, VideoState>(
      listener: (context, state) {
        if (state is VideoError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
            ),
          );
        } else if (state is VideoUploaded) {
          _titleController.clear();
          setState(() {
            _selectedVideoPath = null;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Video uploaded successfully!'),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Choose a Video'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Video Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_selectedVideoPath != null)
                    ThumbnailWidget(videoPath: _selectedVideoPath),
                  const SizedBox(height: 20),
                  SelectVideoButton(
                    onVideoSelected: (videoPath) {
                      setState(() {
                        _selectedVideoPath = videoPath;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ConditionalBuilder(
                    condition: state is! VideoUploading,
                    builder: (context) => ElevatedButton(
                      onPressed: _uploadVideo,
                      child: const CustomTitle(
                        title: 'Upload Video',
                        style: TitleStyle.style18,
                      ),
                    ),
                    fallback: (context) => const CircularProgressIndicator(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
