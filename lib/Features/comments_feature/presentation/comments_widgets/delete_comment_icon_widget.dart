import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comments_bottom_sheet.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/add_comments_cubit/add_comments_cubit.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/widgets/custom_icon_widget.dart';

class DeleteCommentIconWidget extends StatelessWidget {
  const DeleteCommentIconWidget({
    super.key,
    required this.comment,
    required this.state,
  });

  final CommentEntity comment;
  final CommentsBottomSheetState state;

  @override
  Widget build(BuildContext context) {
    return Positioned(
           top: 0,
              right: 8,
      child: IconButton(
        icon: const CustomIconWidget(
          icon: Icons.delete,
          color: ColorController.redAccent,
          size: 25,
        ),
        onPressed: () {
          // CommentsCubit.get(context).comments.removeWhere(
          //       (element) => element.id == comment.id,
          //     );
      
          print(comment.id);
          AddCommentsCubit.get(context).deleteComment(
            userId: UserInfoCubit.get(context).userEntity!.id!,
            videoId: state.widget.videoEntity.id,
            commentId: comment.id,
          );
        },
      ),
    );
  }
}
