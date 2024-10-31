import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comments_bottom_sheet.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/custom_container_widget_body.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/delete_comment_icon_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_contents_screen.dart';

import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';

class CustomContainerWidget extends StatelessWidget {
  const CustomContainerWidget({
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
      child: Stack(
        children: [
          Container(
            width:
                videoState != null ? MediaQuery.of(context).size.width : null,
            decoration: _boxDecoration(),
            child: CustomContainerWidgetbody(
                videoState: videoState, comment: comment),
          ),

          // if (comment?.user.id == UserInfoCubit.get(context).userEntity!.id)
          //   DeleteCommentIconWidget(comment: comment!, state: commentsState!),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: videoState != null ? Colors.transparent : Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: _boxShadow,
      border: Border.all(
        color: videoState != null ? Colors.transparent : Colors.grey.shade300,
      ),
    );
  }

  List<BoxShadow> get _boxShadow {
    return [
      BoxShadow(
        color: videoState != null
            ? Colors.transparent
            : Colors.grey.withOpacity(0.2),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ];
  }
}
