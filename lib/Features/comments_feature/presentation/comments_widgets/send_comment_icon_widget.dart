import 'package:flutter/material.dart';

import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/user_info/cubit/user_info_cubit.dart';
import '../cubit/add_comments_cubit/add_comments_cubit.dart';
import 'comments_bottom_sheet.dart';

class SendIconWidget extends StatelessWidget {
  const SendIconWidget({
    super.key,
    required this.state,
  });

  final CommentsBottomSheetState state;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.send, color: ColorController.blackColor),
      onPressed: () {
        final commentText = state.commentController.text;
        if (commentText.isNotEmpty) {
          AddCommentsCubit.get(context).addComment(
            comment: commentText,
            user: UserInfoCubit.get(context).userEntity!,
            video: state.widget.videoEntity,
          );
          state.commentController.clear();
        }
      },
    );
  }
}
