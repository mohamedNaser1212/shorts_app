import 'package:flutter/material.dart';

import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title.dart';
import '../../domain/comments_entity/comments_entity.dart';

class UserNameAndDateWidgets extends StatelessWidget {
  const UserNameAndDateWidgets({
    super.key,
    required this.comment,
  });

  final CommentEntity comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomTitle(
          title: comment.user.name,
          style: TitleStyle.style16Bold,
          color: ColorController.blackColor,
        ),
        const Spacer(),
        CustomTitle(
          title: _formatTimestamp(comment.timestamp),
          style: TitleStyle.style14,
          color: ColorController.blackColor,
        ),
      ],
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes} min';
    if (difference.inHours < 24) return '${difference.inHours} h';
    return '${difference.inDays} d';
  }
}
