import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comments_bottom_sheet.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/delete_comment_icon_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_contents_screen.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/widgets/custom_read_more_widget.dart';
import 'package:shorts/core/widgets/custom_title.dart';


class CommentsContainerWidget extends StatelessWidget {
  const CommentsContainerWidget({
    super.key,
    this.comment,
    this.commentsState,
    this.videoState,
  });

  final CommentEntity? comment;
  final CommentsBottomSheetState? commentsState;
  final VideoContentsScreenState? videoState;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: videoState != null ? MediaQuery.of(context).size.width : null,
        decoration: BoxDecoration(
          color: videoState != null ? Colors.transparent : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: videoState != null
                  ? Colors.transparent
                  : Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color:
                videoState != null ? Colors.transparent : Colors.grey.shade300,
          ),
        ),
        child: Column(
          // Use Column instead of Row to allow vertical expansion
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitle(
              title: (videoState?.widget.isShared == true
                      ? videoState?.widget.videoEntity.sharedBy?.name
                      : videoState?.widget.videoEntity.user.name) ??
                  comment?.user.name ??
                  'Unknown',
              style: TitleStyle.style16,
              color: videoState != null
                  ? ColorController.whiteColor
                  : ColorController.blackColor,
            ),
            const SizedBox(height: 8),
            if (videoState == null)
              CustomReadMoreWidget(
                text: (videoState?.widget.isShared == true
                        ? videoState?.widget.videoEntity.sharedUserDescription
                        : videoState?.widget.videoEntity.description) ??
                    comment?.content ??
                    'Unknown',
                style: TextStyle(
                  fontSize: 14,
                  color: videoState != null
                      ? ColorController.whiteColor
                      : ColorController.blackColor,
                ),
              ),
            const SizedBox(height: 8), // Add spacing for the delete icon
            if (comment?.user.id == UserInfoCubit.get(context).userEntity!.id)
              DeleteCommentIconWidget(comment: comment!, state: commentsState!),
          ],
        ),
      ),
    );
  }
}
