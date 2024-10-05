import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/comments_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/comments_bottom_sheet.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/widgets/custom_title.dart';

class AddCommentElevatedBotton extends StatelessWidget {
  const AddCommentElevatedBotton({
    super.key,
    required this.state,
  });

  final CommentsBottomSheetState state;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onPressed(context: context),
      child: const CustomTitle(title: 'Add a Comment',style: TitleStyle.style14,),
    );
  }

  void _onPressed({
    required BuildContext context,
  }) {
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
    }
}

