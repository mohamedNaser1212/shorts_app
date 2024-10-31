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
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: state.commentsList.length,
      itemBuilder: (context, index) {
        final comment = state.commentsList[index];
        return CommentItemWidget(
          comment: comment,
          state: state,
        );
      },
    );
  }
}
