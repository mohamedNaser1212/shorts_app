import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/custom_container_widget.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/screens/user_profile_screen.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/videos_profile_picture.dart';
import 'package:shorts/core/functions/navigations_functions.dart';

import '../../domain/comments_entity/comments_entity.dart';

class CommentItemWidget extends StatelessWidget {
  const CommentItemWidget({
    super.key,
    required this.comment,
    // required this.state,
  });

  final CommentEntity comment;
  // final CommentsBottomSheetState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => _onTap(context: context),
            child: UserProfilePicture(comment: comment),
          ),
          const SizedBox(width: 15),
          CustomAddMoreContainerWidget(
            comment: comment,
            //    commentsState: state,
          ),
        ],
      ),
    );
  }

  void _onTap({
    required BuildContext context,
  }) {
    NavigationManager.navigateTo(
      context: context,
      screen: UserProfileScreen(
        user: comment.user,
        // isShared: false,
        // comment: comment,
      ),
    );
  }
}
