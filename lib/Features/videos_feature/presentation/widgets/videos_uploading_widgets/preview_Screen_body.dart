import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/preview_screen.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/thumbnail_preview_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: ThumbnailPreviewWidget(widget: widget),
              ),
            ),
          ),
          // Form Field for description
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: CustomTextFormField(
                  label: 'Video Description',
                  controller: widget.previewState.descriptionController,
                  keyboardType: TextInputType.text,
                  maxLength: 160,
                  isCharacterCountEnabled: true,
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ReusableElevatedButton(
                    onPressed: () {
                      const Uuid uuid = Uuid();

                      if (widget
                          .previewState.descriptionController.text.isNotEmpty) {
                        final video = VideoModel(
                          id: uuid.v1(),
                          description:
                              widget.previewState.descriptionController.text,
                          videoUrl: widget.previewState.widget.outputPath,
                          user: UserInfoCubit.get(context).userEntity!,
                          thumbnail: widget.thumbnailFile?.path ?? '',
                        );

                        UploadVideosCubit.get(context).uploadVideo(
                          videoModel: video,
                        );
                      } else {
                        ToastHelper.showToast(
                            message: 'Please add a description');
                      }
                    },
                    label: 'Upload Video',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
