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
                child: previewState.controller.value.isInitialized
                    ? VideoPlayer(previewState.controller)
                    : const Center(child: CircularProgressIndicator()),
              ),
              // Display thumbnail if available
              if (thumbnailFile != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(
                    thumbnailFile!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
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
