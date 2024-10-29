import 'package:flutter/widgets.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comment_item_widget.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comments_bottom_sheet.dart';

class CommentsListView extends StatelessWidget {
  const CommentsListView({
    super.key,
    required this.state,
    required this.scrollController,
  });

  final CommentsBottomSheetState state;
  final ScrollController scrollController; // Add scrollController as a parameter

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        controller: scrollController, // Use the scroll controller here
        padding: EdgeInsets.zero,
        itemCount: state.commentsList.length,
        itemBuilder: (context, index) {
          final comment = state.commentsList[index];
          return CommentItemWidget(
            comment: comment,
            state: state,
          );
        },
      ),
    );
  }
}
