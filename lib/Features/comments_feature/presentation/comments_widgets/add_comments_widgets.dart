import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comments_bottom_sheet.dart';
import 'package:shorts/Features/comments_feature/presentation/comments_widgets/send_comment_icon_widget.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/add_comments_cubit/add_comments_cubit.dart';

import 'comments_form_field.dart';

class AddCommentsWidgets extends StatelessWidget {
  const AddCommentsWidgets({
    super.key,
    required this.state,
  });

  final CommentsBottomSheetState state;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCommentsCubit, AddCommentsState>(
      listener: (context, addCommentState) async {},
      builder: (context, addCommentState) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.1,
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
              CommentsFormField(state: state),
              SendIconWidget(state: state),
            ],
          ),
        );
      },
    );
  }
}
