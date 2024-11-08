import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comment_item_widget.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comments_bottom_sheet.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';

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
    final comments =
        CommentsCubit.get(context).videoComments[state.widget.videoEntity.id] ??
            [];

    // Check if there are comments
    if (comments.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/empty_comments.png', // Replace with your image asset path
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 10),
            const Text(
              'No comments yet',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    // Display the list of comments if available
    return ListView.separated(
      controller: scrollController,
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];

        return CommentItemWidget(
          comment: comment,
          state: state,
        );
      },
    );
  }
}
