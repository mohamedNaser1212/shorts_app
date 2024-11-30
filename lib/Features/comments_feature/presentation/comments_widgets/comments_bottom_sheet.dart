import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comments_bottom_sheet_body.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/add_comments_cubit/add_comments_cubit.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/widgets/custom_progress_indicator.dart';

import '../../domain/comments_entity/comments_entity.dart';

class CommentsBottomSheet extends StatefulWidget {
  const CommentsBottomSheet({super.key, required this.videoEntity});
  final VideoEntity videoEntity;

  @override
  State<CommentsBottomSheet> createState() => CommentsBottomSheetState();
}

class CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final TextEditingController commentController = TextEditingController();
  late double bottomSheetHeight = MediaQuery.of(context).size.height * 0.75;
  List<CommentEntity> commentsList = [];
  late final ScrollController scrollController = ScrollController();
  bool allCommentsLoaded = false;
  @override
  void initState() {
    super.initState();

    final commentsCubit = CommentsCubit.get(context);

    _loadComments();

    scrollController.addListener(() {
      if (!allCommentsLoaded &&
          scrollController.position.pixels >=
              scrollController.position.maxScrollExtent) {
        _loadComments();
      }
    });
  }

  void _loadComments() {
    final commentsCubit = CommentsCubit.get(context);

    if (!commentsCubit.videoComments.containsKey(widget.videoEntity.id) ||
        commentsCubit.hasMoreCommentsForVideo[widget.videoEntity.id]!) {
      commentsCubit.getComments(videoId: widget.videoEntity.id);
    }
  }

  @override
  void dispose() {
    commentController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        return BlocConsumer<AddCommentsCubit, AddCommentsState>(
          listener: (context, addState) {
            if (addState is AddCommentsSuccessState) {
              commentController.clear();
              CommentsCubit.get(context)
                  .videoComments[widget.videoEntity.id]!
                  .insert(0, addState.comment);
              CommentsCubit.get(context)
                  .getCommentsCount(videoId: widget.videoEntity.id);
            }
          },
          builder: (context, addState) {
            return BlockInteractionLoadingWidget(
              isLoading: addState is AddCommentsLoadingState,
              child: CommentsBottomSheetBody(
                comments: commentsList,
                state: this,
              ),
            );
          },
        );
      },
    );
  }
}
