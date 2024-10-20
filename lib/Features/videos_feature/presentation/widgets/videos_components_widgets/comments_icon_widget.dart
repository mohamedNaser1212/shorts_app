import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comments_bottom_sheet.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';

class CommentsIconWidget extends StatelessWidget {
  const CommentsIconWidget({super.key, required this.videoEntity});
  final VideoEntity videoEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () => _commentsOnPressed(context: context),
          icon: const Icon(
            Icons.comment,
            color: Colors.white,
            size: 35,
          ),
        ),
        const SizedBox(height: 10),
        BlocBuilder<CommentsCubit, CommentsState>(
          builder: (context, state) {
            if (state is GetCommentsCountSuccessState) {
              return Text(
                '${state.commentsCount}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              );
            }
            return const Text(
              '0',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            );
          },
        ),
      ],
    );
  }

  void _commentsOnPressed({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => CommentsBottomSheet(videoEntity: videoEntity),
    );
  }
}
