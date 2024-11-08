import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/custom_container_widget_body.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';

class CustomAddMoreContainerWidget extends StatelessWidget {
  const CustomAddMoreContainerWidget({
    super.key,
    required this.comment,
    //this.commentsState,
    //   this.videoState,
  });

  final CommentEntity comment;
//  final CommentsBottomSheetState? commentsState;
  // final VideoContentsScreenState? videoState;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: ColorController.transparentColor,
        ),
        child: CustomAddMoreContainerWidgetbody(
          //     videoState: videoState,
          comment: comment,
        ),
      ),
    );
  }

  // List<BoxShadow> get _boxShadow {
  //   return [
  //     BoxShadow(
  //       color: videoState != null
  //           ? Colors.transparent
  //           : Colors.grey.withOpacity(0.2),
  //       blurRadius: 8,
  //       offset: const Offset(0, 4),
  //     ),
  //   ];
  // }
}
