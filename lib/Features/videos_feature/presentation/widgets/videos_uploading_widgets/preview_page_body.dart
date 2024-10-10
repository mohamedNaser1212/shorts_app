import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/preview_page.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/thumbnail_preview_widget.dart';
import 'package:shorts/core/widgets/custom_elevated_botton.dart';
import 'package:shorts/core/widgets/reusable_text_form_field.dart';
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
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ThumbnailPreviewWidget(controller: controller, widget: widget),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Video Description',
            controller: widget.previewState.descriptionController,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 10),
        
   
          CustomElevatedButton.uploadVideo(
            context: context,
            previewState: widget.previewState,
            thumbnailFile: widget.thumbnailFile,
          ),
        ],
      ),
    );
    
    
    
    // BlocConsumer<VideoCubit, VideoState>(
    //   listener: _listener,
    //   builder: _builder,
    // );
  }


  // void _listener(context, state) {
  //   if (state is VideoUploadedSuccessState) {
  //     widget.previewState.descriptionController.clear();
  //     NavigationManager.navigateAndFinish(
  //       context: context,
  //       screen: HomeScreen(
  //         currentUser: UserInfoCubit.get(context).userEntity!,
  //       ),
  //     );
  //   }
  // }
}
