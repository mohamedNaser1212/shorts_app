import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/add_comment_elevated_botton.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/comments_bottom_sheet.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/comments_form_field.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/comments_list_view.dart';
import 'package:shorts/core/widgets/custom_title.dart';

class CommentsBottomSheetBody extends StatelessWidget {
  const CommentsBottomSheetBody({
    super.key,
    required this.state,
  });

  final CommentsBottomSheetState state;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SizedBox(
        height: state.bottomSheetHeight,
        child: Column(
          children: [
            const CustomTitle(
              title: 'Comments',
              style: TitleStyle.styleBold18,
            ),
            const SizedBox(height: 8),
            CommentsListView(state: state),
            const SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  CommentsFormFieldWidget(state: state),
                  const SizedBox(height: 16),
                  AddCommentElevatedBotton(state: state),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

