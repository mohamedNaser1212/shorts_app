import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shorts/Features/comments_feature/domain/comments_use_case/add_comments_use_case.dart';
import 'package:shorts/Features/comments_feature/domain/comments_use_case/show_comments_use_case.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/comments_cubit.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/service_locator/service_locator.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/utils/widgets/custom_title.dart';
import 'package:shorts/core/utils/widgets/reusable_widgets_manager/reusable_text_form_field.dart';

import '../../../../core/notification_service/notification_helper.dart';
import '../../../../core/utils/widgets/custom_list_tile.dart';

class CommentsBottomSheet extends StatefulWidget {
  final VideoEntity videoEntity;

  const CommentsBottomSheet({Key? key, required this.videoEntity})
      : super(key: key);

  @override
  _CommentsBottomSheetState createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isTextFieldVisible = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isTextFieldVisible = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final bottomSheetHeight = screenHeight * 0.75;
    final notificationHelper = GetIt.instance.get<NotificationHelper>();

    return BlocProvider(
      create: (context) => CommentsCubit(
        addCommentsUseCase: getIt.get<AddCommentsUseCase>(),
        getCommentsUseCase: getIt.get<GetCommentsUseCase>(),
      )..fetchComments(videoId: widget.videoEntity.id),
      child: BlocBuilder<CommentsCubit, CommentsState>(
        builder: (context, state) {
          return SizedBox(
            height: bottomSheetHeight,
            child: Padding(
              padding: EdgeInsets.only(
                left: 32.0,
                right: 16.0,
                bottom: keyboardHeight,
              ),
              child: Column(
                children: [
                  const CustomTitle(
                    title: 'Comments',
                    style: TitleStyle.styleBold18,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ConditionalBuilder(
                      condition: state is! GetCommentsLoadingState,
                      builder: (context) => ListView.builder(
                        shrinkWrap: true,
                        itemCount: CommentsCubit.get(context).comments.length,
                        itemBuilder: (context, index) {
                          final comment =
                              CommentsCubit.get(context).comments[index];
                          return CustomListTile(
                            title: comment.user.name,
                            subtitle: comment.content,
                            leading: const CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 20,
                            ),
                          );
                        },
                      ),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Visibility(
                    visible: _isTextFieldVisible,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          ReusableTextFormField(
                            label: 'Enter yourr comment ...',
                            controller: _commentController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a comment';
                              }
                              return null;
                            },
                            borderRadius: 10.0,
                          ),
                          // TextField(
                          //   focusNode: _focusNode,
                          //   controller: _commentController,
                          //   decoration: const InputDecoration(
                          //     border: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Colors.black,
                          //       ),
                          //     ),
                          //     hintText: 'Enter your comment',
                          //     // labelText: 'Enter your comment',
                          //   ),
                          //   onSubmitted: (comment) {
                          //     // CommentsCubit.get(context).addComment(
                          //     //   videoId: widget.videoEntity.id,
                          //     //   comment: _commentController.text,
                          //     //   user: UserInfoCubit.get(context).userEntity!,
                          //     //   userId:
                          //     //       UserInfoCubit.get(context).userEntity!.id!,
                          //     //   video: widget.videoEntity,
                          //     // );
                          //     // notificationHelper.sendNotificationToSpecificUser(
                          //     //   fcmToken: widget.videoEntity.user.fcmToken,
                          //     //   userId: widget.videoEntity.user.id!,
                          //     //   title: 'Comment',
                          //     //   body:
                          //     //       'Your video has been commented on by ${UserInfoCubit.get(context).userEntity!.name}',
                          //     //   context: context,
                          //     // );
                          //     // _commentController.clear();
                          //     // Navigator.of(context).pop();
                          //   },
                          // ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              CommentsCubit.get(context).addComment(
                                videoId: widget.videoEntity.id,
                                comment: _commentController.text,
                                user: UserInfoCubit.get(context).userEntity!,
                                userId:
                                    UserInfoCubit.get(context).userEntity!.id!,
                                video: widget.videoEntity,
                              );
                              notificationHelper.sendNotificationToSpecificUser(
                                fcmToken: widget.videoEntity.user.fcmToken,
                                userId: widget.videoEntity.user.id!,
                                title: 'Comment',
                                body:
                                    'Your video has been commented on by ${UserInfoCubit.get(context).userEntity!.name}',
                                context: context,
                              );
                              _commentController.clear();
                            },
                            child: const Text('Add a Comment'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Button to show text field
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
