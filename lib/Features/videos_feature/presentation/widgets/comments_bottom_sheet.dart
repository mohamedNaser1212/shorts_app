import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/comments_cubit.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/comments_bottom_sheet_body.dart';
import 'package:shorts/core/widgets/custom_progress_indicator.dart';
import '../../../comments_feature/domain/comments_entity/comments_entity.dart';

class CommentsBottomSheet extends StatefulWidget {
  const CommentsBottomSheet({super.key, required this.videoEntity});
  final VideoEntity videoEntity;

  @override
  State<CommentsBottomSheet> createState() => CommentsBottomSheetState();
}

class CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final TextEditingController commentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late var screenHeight = MediaQuery.of(context).size.height;
  late var bottomSheetHeight = screenHeight * 0.75;
  List<CommentEntity> commentsList = [];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });

    CommentsCubit.get(context).getComments(widget.videoEntity.id);
  }

  @override
  void dispose() {
    commentController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        if (state is GetCommentsSuccessState) {
          commentsList = state.comments;
        } else if (state is GetCommentsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetCommentsErrorState) {
          return Center(child: Text(state.message));
        }

        return CustomProgressIndicator(
          isLoading: state is AddCommentsLoadingState,
          child: CommentsBottomSheetBody(
            state: this,
          ),
        );
      },
    );
  }
}
