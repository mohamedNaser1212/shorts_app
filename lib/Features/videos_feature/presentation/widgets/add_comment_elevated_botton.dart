import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/comments_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/comments_bottom_sheet.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';

class AddCommentElevatedBotton extends StatelessWidget {
  const AddCommentElevatedBotton({
    super.key,
    required this.state,
  });

  final CommentsBottomSheetState state;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final commentText = state.commentController.text;
        if (commentText.isNotEmpty) {
          CommentsCubit.get(context).addComment(
            videoId: state.widget.videoEntity.id,
            comment: commentText,
            user: UserInfoCubit.get(context).userEntity!,
            userId: UserInfoCubit.get(context).userEntity!.id!,
            video: state.widget.videoEntity,
          );
          state.commentController.clear();
        }
      },
      child: const Text('Add a Comment'),
    );
  }
}

