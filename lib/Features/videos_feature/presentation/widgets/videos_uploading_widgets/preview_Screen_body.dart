import 'dart:io';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/preview_screen.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/thumbnail_preview_widget.dart';
import 'package:shorts/core/widgets/reusable_text_form_field.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/functions/toast_function.dart';
import '../../../../../core/user_info/cubit/user_info_cubit.dart';
import '../../../../../core/widgets/reusable_elevated_botton.dart';
import '../../../../authentication_feature/data/user_model/user_model.dart';
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
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Adding space from the top
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 50.0), // Add space from the top
              child: Center(
                child: ThumbnailPreviewWidget(
                    controller: controller, widget: widget),
              ),
            ),
          ),
          // Form Field for description
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 16.0), // Adding vertical space
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
                          user: UserModel(
                            id: UserInfoCubit.get(context).userEntity!.id,
                            name: UserInfoCubit.get(context).userEntity!.name,
                            email: UserInfoCubit.get(context).userEntity!.email,
                            phone: UserInfoCubit.get(context).userEntity!.phone,
                            bio: UserInfoCubit.get(context).userEntity!.bio,
                            profilePic: UserInfoCubit.get(context)
                                .userEntity!
                                .profilePic,
                            fcmToken:
                                UserInfoCubit.get(context).userEntity!.fcmToken,
                            likesCount: UserInfoCubit.get(context)
                                .userEntity!
                                .likesCount,
                            followingCount: UserInfoCubit.get(context)
                                .userEntity!
                                .followingCount,
                            followersCount: UserInfoCubit.get(context)
                                .userEntity!
                                .followersCount,
                          ),
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
