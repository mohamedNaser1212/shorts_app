import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comments_bottom_sheet.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_icon_widget.dart';
import 'package:shorts/core/widgets/custom_title.dart';

class CommentsIconWidget extends StatelessWidget {
  const CommentsIconWidget({super.key, required this.videoEntity});
  final VideoEntity videoEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () => _commentsOnPressed(context: context),
          icon: const CustomIconWidget(
            icon: Icons.comment,
            color: ColorController.whiteColor,
          ),
        ),
        const SizedBox(height: 10),
        BlocBuilder<CommentsCubit, CommentsState>(
          builder: (context, state) {
            final count =
                CommentsCubit.get(context).commentsCount[videoEntity.id] ?? 0;

            return CustomTitle(
              title: count.toString(),
              style: TitleStyle.style16,
              color: ColorController.whiteColor,
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
