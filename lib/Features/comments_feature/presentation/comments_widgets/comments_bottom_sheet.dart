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
  late double bottomSheetHeight = MediaQuery.of(context).size.height * 0.75;
  List<CommentEntity> commentsList = [];
  late final ScrollController scrollController = ScrollController();
  int currentPage = 0;
  bool allCommentsLoaded = false;

  @override
  void initState() {
    super.initState();

    // Load initial comments
    _loadComments();

    // Set up scroll listener for pagination
    scrollController.addListener(() {
      if (!allCommentsLoaded && scrollController.position.pixels >= scrollController.position.maxScrollExtent * 0.7) {
        _loadComments();
      }
    });
  }

  void _loadComments() {
    context.read<CommentsCubit>().getComments(
      videoId: widget.videoEntity.id,
      page: currentPage,
    );
  }

  @override
  void dispose() {
    commentController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentsCubit, CommentsState>(
      listener: (context, state) {
        if (state is GetCommentsSuccessState) {
          // Update the current page for next request
          currentPage++;

          // Check if all comments are loaded (for disabling further pagination)
          if (state.comments!.isEmpty) {
            allCommentsLoaded = true;
          } else {
            // Accumulate comments only in success state
            commentsList.addAll(state.comments!);
          }
        } else if (state is GetCommentsErrorState) {
          // Handle any error cases (show a message, etc.)
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      builder: (context, state) {
        if (state is GetCommentsLoadingState && commentsList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return BlocBuilder<AddCommentsCubit, AddCommentsState>(
          builder: (context, addState) {
            return CustomProgressIndicator(
              isLoading: addState is AddCommentsLoadingState || addState is DeleteCommentLoadingState,
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
