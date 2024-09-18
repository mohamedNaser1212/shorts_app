import 'package:flutter/material.dart';

import '../../../../core/utils/widgets/custom_list_tile.dart';
import '../../../comments_feature/domain/comments_entity/comments_entity.dart';

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
      leading: const CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 20,
      ),
    );
  }
}
