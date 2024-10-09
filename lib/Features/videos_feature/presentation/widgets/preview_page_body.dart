import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/layout/presentation/screens/home_page.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/preview_page.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

class PreviewPageBody extends StatelessWidget {
  const PreviewPageBody({
    super.key,
    required this.previewState,
    this.thumbnailFile,
  });

  final PreviewPageState previewState;
  final File? thumbnailFile;
  final Uuid _uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoCubit, VideoState>(
      listener: (context, state) {
        if (state is VideoUploadedSuccessState) {
          previewState.descriptionController.clear();
          previewState.widget.outputPath = '';
          NavigationManager.navigateAndFinish(
            context: context,
            screen: HomeScreen(
              currentUser: UserInfoCubit.get(context).userEntity!,
            ),
          );
        }
      },
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: previewState.controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Display thumbnail if available
                    if (thumbnailFile != null)
                      GestureDetector(
                        onTap: () {
                          // Navigate to a new page to show the video
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerScreen(
                                videoPath: previewState.widget.outputPath,
                              ),
                            ),
                          );
                        },
                        child: Image.file(
                          thumbnailFile!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    // Add the play icon on top of the thumbnail
                    if (thumbnailFile != null)
                      const Icon(
                        Icons.play_circle_fill,
                        size: 60,
                        color: Colors.white,
                      ),
                    // Show video player if it's initialized
                    if (previewState.controller.value.isInitialized &&
                        thumbnailFile == null)
                      VideoPlayer(previewState.controller),
                    // Show a loading indicator if the video is not initialized
                    if (!previewState.controller.value.isInitialized)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: previewState.descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Video Description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (state is VideoUploadLoadingState)
                const CircularProgressIndicator(),
              ElevatedButton(
                onPressed: () {
                  // Handle upload action
                  if (previewState.descriptionController.text.isNotEmpty) {
                    final video = VideoModel(
                      id: _uuid.v1(),
                      description: previewState.descriptionController.text,
                      videoUrl: previewState.widget.outputPath,
                      user: UserInfoCubit.get(context).userEntity!,
                      thumbnail: thumbnailFile?.path ?? '', // Handle null case
                    );

                    VideoCubit.get(context).uploadVideo(videoModel: video);
                  }
                },
                child: const Text('Upload Video'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;

  const VideoPlayerScreen({super.key, required this.videoPath});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Player')),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            alignment: Alignment.center,
            children: [
              VideoPlayer(_controller),
              // Pause icon to play video
              IconButton(
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 60,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
