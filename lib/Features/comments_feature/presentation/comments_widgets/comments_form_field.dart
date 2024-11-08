import 'package:flutter/material.dart';

import '../../../../core/widgets/reusable_text_form_field.dart';
import 'comments_bottom_sheet.dart';

class CommentsFormField extends StatelessWidget {
  const CommentsFormField({
    super.key,
    required this.state,
  });

  final CommentsBottomSheetState state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}
