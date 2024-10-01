import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/comments_bottom_sheet.dart';
import 'package:shorts/core/widgets/reusable_text_form_field.dart';

class CommentsFormFieldWidget extends StatelessWidget {
  const CommentsFormFieldWidget({
    super.key,
    required this.state,
  });

  final CommentsBottomSheetState state;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      label: 'Enter your comment ...',
      controller: state.commentController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a comment';
        }
        return null;
      },
      borderRadius: 10.0,
    );
  }
}
