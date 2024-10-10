import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/layout/presentation/screens/home_page.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/play_icon_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/preview_page.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

class PreviewPageBody extends StatefulWidget {
  const PreviewPageBody({
    super.key,
    required this.previewState,
    this.thumbnailFile,
  });
  final PreviewPageState previewState;
  final File? thumbnailFile;

  @override
  State<PreviewPageBody> createState() => _PreviewPageBodyState();
}

class _PreviewPageBodyState extends State<PreviewPageBody> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(File(widget.thumbnailFile!.path))
      ..initialize().then((_) {
        setState(() {});
        controller.play();
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  final Uuid _uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoCubit, VideoState>(
      listener: (context, state) {
        if (state is VideoUploadedSuccessState) {
          widget.previewState.descriptionController.clear();

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
                aspectRatio: controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Display thumbnail if available
                    if (widget.thumbnailFile != null)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerScreen(
                                videoPath:
                                    widget.previewState.widget.outputPath,
                              ),
                            ),
                          );
                        },
                        child: Image.file(
                          widget.thumbnailFile!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    // Add the play icon on top of the thumbnail
                    if (widget.thumbnailFile != null)
                      const Icon(
                        Icons.play_circle_fill,
                        size: 60,
                        color: Colors.white,
                      ),
                    // Show video player if it's initialized
                    if (controller.value.isInitialized &&
                        widget.thumbnailFile == null)
                      VideoPlayer(controller),
                    // Show a loading indicator if the video is not initialized
                    if (!controller.value.isInitialized)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: widget.previewState.descriptionController,
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
                  if (widget
                      .previewState.descriptionController.text.isNotEmpty) {
                    final video = VideoModel(
                      id: _uuid.v1(),
                      description:
                          widget.previewState.descriptionController.text,
                      videoUrl: widget.previewState.widget.outputPath,
                      user: UserInfoCubit.get(context).userEntity!,
                      thumbnail:
                          widget.thumbnailFile?.path ?? '', // Handle null case
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
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
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
              VideoPlayer(controller),

              PlayIcon(
                videoPlayerScreenState: controller,
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
