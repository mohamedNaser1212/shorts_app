import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/add_comments_cubit/add_comments_cubit.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comments_bottom_sheet_body.dart';
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
  late var screenHeight = MediaQuery.of(context).size.height;
  late var bottomSheetHeight = screenHeight * 0.75;
  List<CommentEntity> commentsList = [];
  ScrollController scrollController = ScrollController();
  int currentPage = 1;
  final int commentsPerPage = 7;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();

    _loadComments();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent * 0.7 &&
          !isLoadingMore) {
        _loadMoreComments(); 
      }
    });
  }

  void _loadComments() {
    CommentsCubit.get(context).getComments(
      videoId: widget.videoEntity.id,
      page: currentPage,
      limit: commentsPerPage,
    );
  }

  void _loadMoreComments() {
    setState(() => isLoadingMore = true);
    currentPage++;
    CommentsCubit.get(context).getComments(
      videoId: widget.videoEntity.id,
      page: currentPage,
      limit: commentsPerPage,
    );
    setState(() => isLoadingMore = false);
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
        if (state is GetCommentsSuccessState) {
          commentsList = [...commentsList, ...state.comments];
        } else if (state is GetCommentsLoadingState && commentsList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetCommentsErrorState) {
          return Center(child: Text(state.message));
        }

        return BlocBuilder<AddCommentsCubit, AddCommentsState>(
          builder: (context, state) {
            if (state is DeleteCommentSuccessState) {
              CommentsCubit.get(context).getComments(
                videoId: widget.videoEntity.id,
                page: currentPage,
              );
            }
            return CustomProgressIndicator(
              isLoading: state is AddCommentsLoadingState ||
                  state is DeleteCommentLoadingState,
              child: CommentsBottomSheetBody(
                state: this,

                //comments: commentsList,
              ),
            );
          },
        );
      },
    );
  }
}
