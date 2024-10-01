
import 'package:flutter/widgets.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/comment_item_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/comments_bottom_sheet.dart';

class CommentsListView extends StatelessWidget {
  const CommentsListView({
    super.key,
    required this.state,
  });

  final CommentsBottomSheetState state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        itemCount: state.commentsList.length,
        itemBuilder: (context, index) {
          final comment = state.commentsList[index];
          return CommentItemWidget(comment: comment);
        },
      ),
    );
  }
}
