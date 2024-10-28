import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comments_bottom_sheet.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/delete_comment_icon_widget.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/widgets/custom_read_more_widget.dart';
import 'package:shorts/core/widgets/custom_title.dart';

class CommentsContainerWidget extends StatelessWidget {
  const CommentsContainerWidget({
    super.key,
    required this.comment,
    required this.state,
  });

  final CommentEntity comment;
  final CommentsBottomSheetState state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
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
                  CustomReadMoreWidget(
                    text: comment.content,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const Spacer(),
              if (comment.user.id == UserInfoCubit.get(context).userEntity!.id)
                DeleteCommentIconWidget(comment: comment, state: state),
            ],
          ),
        ),
      ),
    );
  }
}
