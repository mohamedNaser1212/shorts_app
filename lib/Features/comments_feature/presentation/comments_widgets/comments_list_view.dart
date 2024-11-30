import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comment_item_widget.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comments_bottom_sheet.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';

import 'empty_comments_widget.dart';

class CommentsListView extends StatefulWidget {
  const CommentsListView({
    super.key,
    required this.state,
  });

  final CommentsBottomSheetState state;

  @override
  State<CommentsListView> createState() => _CommentsListViewState();
}

class _CommentsListViewState extends State<CommentsListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        final commentsCubit = CommentsCubit.get(context);
        final comments =
            commentsCubit.videoComments[widget.state.widget.videoEntity.id] ??
                [];
        final hasMoreComments = commentsCubit
                .hasMoreCommentsForVideo[widget.state.widget.videoEntity.id] ??
            false;
        final isFetchingComments = state is GetCommentsLoadingState;

        if (comments.isEmpty) {
          return const EmptyCommentsWidget();
        }

        final itemCount =
            comments.length + (hasMoreComments && !isFetchingComments ? 1 : 0);

        return ListView.separated(
          controller: widget.state.scrollController,
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            if (index == comments.length &&
                comments.length >= 6 &&
                hasMoreComments) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: CircularProgressIndicator(color: Colors.black),
                ),
              );
            } else if (index < comments.length) {
              final comment = comments[index];
              return CommentItemWidget(comment: comment);
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
