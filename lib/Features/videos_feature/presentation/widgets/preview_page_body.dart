import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/layout/presentation/screens/home_page.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/preview_page.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:video_player/video_player.dart';

class PreviewPageBody extends StatelessWidget {
  const PreviewPageBody({
    super.key,
    required this.previewState,
  });

  // final VideoPlayerController _controller;
  // final TextEditingController _descriptionController;
  // final Preview widget;
  final PreviewPageState previewState;
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
              ));
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: previewState.descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  VideoCubit.get(context).uploadVideo(
                    videoPath: previewState.widget.outputPath,
                    description: previewState.descriptionController.text,
                    user: UserInfoCubit.get(context).userEntity!,
                  );
                },
                child: const Text('Upload'),
              ),
            ],
          ),
        );
      },
    );
  }
}
