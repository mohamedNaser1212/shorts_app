import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_contents_screen.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_read_more_widget.dart';
import 'package:shorts/core/widgets/custom_title.dart';

class CustomContainerWidgetbody extends StatelessWidget {
  const CustomContainerWidgetbody({
    super.key,
    required this.videoState,
    required this.comment,
  });

  final VideoContentsScreenState? videoState;
  final CommentEntity? comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitle(
            title: (videoState?.widget.isShared == true
                    ? videoState?.widget.videoEntity.sharedBy?.name
                    : videoState?.widget.videoEntity.user.name) ??
                comment?.user.name ??
                'Unknown',
            style: TitleStyle.style16,
            color: videoState != null
                ? ColorController.whiteColor
                : ColorController.blackColor,
          ),
          const SizedBox(height: 16), // Adjusted spacing
          if (videoState == null)
            CustomReadMoreWidget(
              text: (videoState?.widget.isShared == true
                      ? videoState
                          ?.widget.videoEntity.sharedUserDescription
                      : videoState?.widget.videoEntity.description) ??
                  comment?.content ??
                  'Unknown',
              style: TextStyle(
                fontSize: 14,
                color: videoState != null
                    ? ColorController.whiteColor
                    : ColorController.blackColor,
              ),
            ),
        ],
      ),
    );
  }
}
