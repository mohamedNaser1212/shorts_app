import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/add_comments_widgets.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comments_bottom_sheet.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comments_list_view.dart';
import 'package:shorts/core/widgets/custom_title.dart';

import '../../../../core/managers/styles_manager/color_manager.dart';

class CommentsBottomSheetBody extends StatelessWidget {
  const CommentsBottomSheetBody({
    super.key,
    required this.state,
    this.comments,
  });

  final CommentsBottomSheetState state;
  final List<CommentEntity>? comments;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SizedBox(
        height: state.bottomSheetHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomTitle(
              title: 'Comments',
              style: TitleStyle.styleBold18,
              color: ColorController.blackColor,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: CommentsListView(
                state: state,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                children: [
                  AddCommentsWidgets(state: state),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
