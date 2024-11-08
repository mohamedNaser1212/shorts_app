import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/user_name_and_date_widgets.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_read_more_widget.dart';

class CustomContainerWidgetbody extends StatelessWidget {
  const CustomContainerWidgetbody({
    super.key,
    required this.comment,
  });

  final CommentEntity comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserNameAndDateWidgets(
            comment: comment,
          ),
          const SizedBox(height: 16), // Adjusted spacing
          CustomReadMoreWidget(
            text: comment.content,
            style: const TextStyle(
              fontSize: 16,
              color: ColorController.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
