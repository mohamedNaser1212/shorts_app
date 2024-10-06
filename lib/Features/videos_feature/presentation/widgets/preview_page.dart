import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class Preview extends StatefulWidget {
  const Preview({super.key, required this.outputPath});

  final String outputPath;

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  late VideoPlayerController _controller;
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.outputPath))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Preview',
      ),
      body: Center(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: _controller.value.isInitialized
                  ? VideoPlayer(_controller)
                  : const Center(child: CircularProgressIndicator()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                VideoCubit.get(context).uploadVideo(
                  videoPath: widget.outputPath,
                  description: _descriptionController.text,
                  user: UserInfoCubit.get(context).userEntity!,
                );
              },
              child: const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
