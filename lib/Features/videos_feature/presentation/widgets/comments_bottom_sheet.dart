import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/comments_cubit.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/utils/widgets/custom_title.dart';
import 'package:shorts/core/utils/widgets/reusable_widgets_manager/reusable_text_form_field.dart';

import '../../../../core/notification_service/notification_helper.dart';
import '../../../comments_feature/domain/comments_entity/comments_entity.dart';
import 'comment_item_widget.dart';

class CommentsBottomSheet extends StatefulWidget {
  const CommentsBottomSheet({super.key, required this.videoEntity});
  final VideoEntity videoEntity;

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
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

    // Start listening to comments
    CommentsCubit.get(context).startListeningToComments(widget.videoEntity.id);
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

    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        List<CommentEntity> commentsList = [];

        if (state is GetCommentsSuccessState) {
          commentsList = state.comments;
        }

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
                  child: ListView.builder(
                    reverse: true,
                    itemCount: commentsList.length,
                    itemBuilder: (context, index) {
                      final comment = commentsList[index];
                      return CommentItemWidget(comment: comment);
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: [
                      ReusableTextFormField(
                        label: 'Enter your comment ...',
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
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          final commentText = _commentController.text;
                          if (commentText.isNotEmpty) {
                            CommentsCubit.get(context).addComment(
                              videoId: widget.videoEntity.id,
                              comment: commentText,
                              user: UserInfoCubit.get(context).userEntity!,
                              userId:
                                  UserInfoCubit.get(context).userEntity!.id!,
                              video: widget.videoEntity,
                            );
                            // notificationHelper.sendNotificationToSpecificUser(
                            //   fcmToken: widget.videoEntity.user.fcmToken,
                            //   userId: widget.videoEntity.user.id!,
                            //   title: 'Comment',
                            //   body:
                            //       'Your video has been commented on by ${UserInfoCubit.get(context).userEntity!.name}',
                            //   context: context,
                            // );

                            _commentController.clear();
                          }
                        },
                        child: const Text('Add a Comment'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
