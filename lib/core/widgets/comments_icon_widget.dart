import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comments_bottom_sheet.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';

class CommentsIconWidget extends StatelessWidget {
  const CommentsIconWidget({super.key,required  this.videoEntity});
final VideoEntity videoEntity;
  @override
  Widget build(BuildContext context) {
    return  IconButton(
          onPressed: () => _commentsOnPressed(context: context),
          icon: const Icon(
            Icons.comment,
            color: Colors.white,
            size: 35,
          ),
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