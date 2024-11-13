// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shorts/Features/comments_feature/presentation/comments_widgets/comments_bottom_sheet.dart';
// import 'package:shorts/Features/comments_feature/presentation/cubit/add_comments_cubit/add_comments_cubit.dart';
// import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';
// import 'package:shorts/core/functions/toast_function.dart';
// import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
// import 'package:shorts/core/widgets/custom_title.dart';
//
// class AddCommentElevatedButton extends StatefulWidget {
//   const AddCommentElevatedButton({
//     super.key,
//     required this.state,
//   });
//
//   final CommentsBottomSheetState state;
//
//   @override
//   State<AddCommentElevatedButton> createState() =>
//       _AddCommentElevatedButtonState();
// }
//
// class _AddCommentElevatedButtonState extends State<AddCommentElevatedButton> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AddCommentsCubit, AddCommentsState>(
//       listener: (context, state) async {
//         if (state is AddCommentsSuccessState) {
//           // Refresh comments on success
//           CommentsCubit.get(context)
//               .videoComments[widget.state.widget.videoEntity.id] = [];
//           CommentsCubit.get(context)
//                   .hasMoreCommentsForVideo[widget.state.widget.videoEntity.id] =
//               true;
//           CommentsCubit.get(context).getComments(
//               videoId: widget.state.widget.videoEntity.id, page: 0);
//           await CommentsCubit.get(context)
//               .getCommentsCount(videoId: widget.state.widget.videoEntity.id);
//
//           // refreshCommentsForVideo(
//           //   videoId: widget.state.widget.videoEntity.id,
//           // );
//         } else if (state is AddCommentsErrorState) {
//           ToastHelper.showToast(
//             message: state.message,
//           );
//         }
//       },
//       builder: (context, state) {
//         return ElevatedButton(
//           onPressed: () => _onPressed(context: context),
//           child: const CustomTitle(
//             title: 'Add a Comment',
//             style: TitleStyle.style14,
//           ),
//         );
//       },
//     );
//   }
//
//   void _onPressed({
//     required BuildContext context,
//   }) {
//     final commentText = widget.state.commentController.text;
//     if (commentText.isNotEmpty) {
//       AddCommentsCubit.get(context).addComment(
//         comment: commentText,
//         user: UserInfoCubit.get(context).userEntity!,
//         video: widget.state.widget.videoEntity,
//       );
//       widget.state.commentController.clear();
//     }
//   }
// }
