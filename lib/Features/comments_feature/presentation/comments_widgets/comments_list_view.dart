import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comment_item_widget.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comments_bottom_sheet.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';

import 'empty_comments_widget.dart';

class CommentsListView extends StatefulWidget {
  const CommentsListView({
    super.key,
    required this.state,
    required this.scrollController,
  });

  final CommentsBottomSheetState state;
  final ScrollController scrollController;

  @override
  State<CommentsListView> createState() => _CommentsListViewState();
}

class _CommentsListViewState extends State<CommentsListView> {
  @override
  Widget build(BuildContext context) {
    final commentsCubit = CommentsCubit.get(context);
    final comments =
        commentsCubit.videoComments[widget.state.widget.videoEntity.id] ?? [];
    final hasMoreComments = commentsCubit
            .hasMoreCommentsForVideo[widget.state.widget.videoEntity.id] ??
        false;

    if (comments.isEmpty) {
      return const EmptyCommentsWidget();
    }

    return ListView.separated(
      controller: widget.scrollController,
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: comments.length + (hasMoreComments ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == comments.length && hasMoreComments) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          );
        }

        final comment = comments[index];
        return CommentItemWidget(
          comment: comment,
        );
      },
    );
  }
}
