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
  int currentPage = 1;
  bool allCommentsLoaded = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          !CommentsCubit.get(context).isLastComment &&
          CommentsCubit.get(context).lastComment != null &&
          CommentsCubit.get(context).comments.isNotEmpty &&
          !isLoading) {
        //setState(() async {
        isLoading = true;

        BlocProvider.of<CommentsCubit>(context).getStartAfterDocument(
          widget.videoEntity.id,
        //  page: currentPage + 1,
        );
        //  });

        isLoading = false;
      }
    });
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
          allCommentsLoaded = state.comments.isEmpty;
          if (!allCommentsLoaded) commentsList.addAll(state.comments);
        } else if (state is GetCommentsLoadingState && commentsList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetCommentsErrorState) {
          return Center(child: Text(state.message));
        }

        return BlocBuilder<AddCommentsCubit, AddCommentsState>(
          builder: (context, addState) {
            return CustomProgressIndicator(
              isLoading: addState is AddCommentsLoadingState ||
                  addState is DeleteCommentLoadingState,
              child: CommentsBottomSheetBody(state: this),
            );
          },
        );
      },
    );
  }
}
