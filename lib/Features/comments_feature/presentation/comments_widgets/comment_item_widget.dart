import 'package:flutter/material.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/videos_profile_picture.dart';

import '../../../../core/widgets/custom_list_tile.dart';
import '../../domain/comments_entity/comments_entity.dart';

class CommentItemWidget extends StatelessWidget {
  const CommentItemWidget({
    super.key,
    required this.comment,
  });

  final CommentEntity comment;

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: comment.user.name,
      subtitle: comment.content,
      leading: UserProfilePicture(comment: comment),
    );
  }
}
