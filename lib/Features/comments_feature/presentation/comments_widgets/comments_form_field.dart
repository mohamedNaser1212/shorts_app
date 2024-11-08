import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comments_bottom_sheet.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/send_comment_icon_widget.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/add_comments_cubit/add_comments_cubit.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';
import 'package:shorts/core/functions/toast_function.dart';
import 'package:shorts/core/widgets/reusable_text_form_field.dart';

class CommentsFormFieldWidget extends StatelessWidget {
  const CommentsFormFieldWidget({
    super.key,
    required this.state,
  });

  final CommentsBottomSheetState state;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCommentsCubit, AddCommentsState>(
      listener: (context, addCommentState) async {
        if (addCommentState is AddCommentsSuccessState) {
          // Refresh comments on success
          final videoId = state.widget.videoEntity.id;
          CommentsCubit.get(context).videoComments[videoId] = [];
          CommentsCubit.get(context).hasMoreCommentsForVideo[videoId] = true;
          CommentsCubit.get(context).getComments(videoId: videoId, page: 0);
          await CommentsCubit.get(context).getCommentsCount(videoId: videoId);
        } else if (addCommentState is AddCommentsErrorState) {
          ToastHelper.showToast(message: addCommentState.message);
        }
      },
      builder: (context, addCommentState) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: state.commentController,
                  keyboardType: TextInputType.text,
                  controllerBlackColor: true,
                  hintText: 'Enter your comment...',
                  showBorder: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a comment';
                    }
                    return null;
                  },
                ),
              ),
              // Send Icon Button with BLoC functionality
              SendIconWidget(state: state),
            ],
          ),
        );
      },
    );
  }
}
