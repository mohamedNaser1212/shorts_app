import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/image_thumbnail.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/utils/widgets/custom_title.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../videos_feature/presentation/video_cubit/video_cubit.dart';
import '../../../videos_feature/presentation/widgets/thumbnail_page.dart';

class ChooseVideoPage extends StatefulWidget {
  const ChooseVideoPage({super.key});

  @override
  State<ChooseVideoPage> createState() => _ChooseVideoPageState();
}

class _ChooseVideoPageState extends State<ChooseVideoPage> {
  final TextEditingController _titleController = TextEditingController();
  String? _selectedVideoPath;
  String? _thumbnailPath;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    final result = await context.read<VideoCubit>().pickVideo();
    setState(() {
      _selectedVideoPath = result;
    });

    if (_selectedVideoPath != null) {
      _generateThumbnail(_selectedVideoPath!);
    }
  }

  Future<void> _generateThumbnail(String videoPath) async {
    final tempDir = await getTemporaryDirectory();
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      thumbnailPath: tempDir.path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 100,
      quality: 75,
    );

    setState(() {
      _thumbnailPath = thumbnailPath;
    });
  }

  Future<void> _uploadVideo() async {
    final userEntity = UserInfoCubit.get(context).userEntity;

    if (userEntity != null && _selectedVideoPath != null) {
      VideoCubit.get(context).uploadVideo(
        videoPath: _selectedVideoPath!,
        description: _titleController.text,
        user: userEntity,
      );
    }
  }

  void _navigateToThumbnailPage(BuildContext context) {
    if (_selectedVideoPath != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ThumbnailPage(videoPath: _selectedVideoPath!),
        ),
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
            _thumbnailPath = null;
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
                  if (_thumbnailPath != null)
                    GestureDetector(
                      onTap: () => _navigateToThumbnailPage(context),
                      child: ImageThumbnail(thumbnailPath: _thumbnailPath!),
                    ),
                  ElevatedButton(
                    onPressed: _pickVideo,
                    child: const CustomTitle(
                      title: 'Select Video',
                      style: TitleStyle.style18,
                    ),
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
