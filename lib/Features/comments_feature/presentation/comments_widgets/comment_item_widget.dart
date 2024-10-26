import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comments_bottom_sheet.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/add_comments_cubit/add_comments_cubit.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/videos_profile_picture.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/widgets/custom_title.dart';
import '../../domain/comments_entity/comments_entity.dart';

class CommentItemWidget extends StatelessWidget {
  const CommentItemWidget({
    super.key,
    required this.comment,
    required this.state,
  });

  final CommentEntity comment;
  final CommentsBottomSheetState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserProfilePicture(comment: comment),
          const SizedBox(width: 15),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTitle(
                          title: comment.user.name,
                          style: TitleStyle.style16Bold,
                        ),
                        const SizedBox(height: 8),
                        CustomTitle(
                          title: comment.content,
                          style: TitleStyle.style14,
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (comment.user.id ==
                        UserInfoCubit.get(context).userEntity!.id)
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: ColorController.redAccent,
                        ),
                        onPressed: () {
                          CommentsCubit.get(context).comments.removeWhere(
                                (element) => element.id == comment.id,
                              );

                          print(comment.id);
                          AddCommentsCubit.get(context).deleteComment(
                            userId: UserInfoCubit.get(context).userEntity!.id!,
                            videoId: state.widget.videoEntity.id,
                            commentId: comment.id,
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
