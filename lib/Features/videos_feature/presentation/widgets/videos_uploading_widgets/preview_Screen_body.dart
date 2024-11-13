import 'dart:io';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/preview_screen.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/thumbnail_preview_widget.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/reusable_text_form_field.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/functions/toast_function.dart';
import '../../../../../core/user_info/cubit/user_info_cubit.dart';
import '../../../../../core/widgets/reusable_elevated_botton.dart';
import '../../../data/model/video_model.dart';
import '../../video_cubit/upload_videos_cubit/upload_videos_cubit.dart';

class PreviewScreeBody extends StatefulWidget {
  const PreviewScreeBody({
    super.key,
    required this.previewState,
    this.thumbnailFile,
  });
  final PreviewScreenState previewState;
  final File? thumbnailFile;

  @override
  State<PreviewScreeBody> createState() => _PreviewScreeBodyState();
}

class _PreviewScreeBodyState extends State<PreviewScreeBody> {
  late CachedVideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = CachedVideoPlayerController.file(
      File(widget.thumbnailFile?.path ?? widget.previewState.widget.outputPath),
    )..initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ThumbnailPreviewWidget(controller: controller, widget: widget),
            const SizedBox(height: 10),
            CustomTextFormField(
              label: 'Video Description',
              controller: widget.previewState.descriptionController,
              keyboardType: TextInputType.text,
              maxLength: 160,
              isCharacterCountEnabled: true,
            ),
            const SizedBox(height: 40),
            ReusableElevatedButton(
              backColor: ColorController.purpleColor,
              onPressed: () {
                const Uuid uuid = Uuid();

                if (widget.previewState.descriptionController.text.isNotEmpty) {
                  final video = VideoModel(
                    id: uuid.v1(),
                    description: widget.previewState.descriptionController.text,
                    videoUrl: widget.previewState.widget.outputPath,
                    user: UserInfoCubit.get(context).userEntity!,
                    thumbnail: widget.thumbnailFile?.path ?? '',
                  );

                  UploadVideosCubit.get(context)
                      .uploadVideo(videoModel: video, sharedBy: null);
                } else {
                  ToastHelper.showToast(message: 'Please add a description');
                }
              },
              label: 'Upload Video',
            ),
            // CustomElevatedButton.uploadVideo(
            //   context: context,
            //   previewState: widget.previewState,
            //   thumbnailFile: widget.thumbnailFile,
            // ),
          ],
        ),
      ),
    );
  }
}
