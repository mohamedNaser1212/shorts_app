part of 'add_comments_cubit.dart';

class AddCommentsState {}

class AddCommentsLoadingState extends AddCommentsState {}

class AddCommentsSuccessState extends AddCommentsState {
  final CommentEntity comment;
  AddCommentsSuccessState({required this.comment});
}

class AddCommentsErrorState extends AddCommentsState {
  final String message;
  AddCommentsErrorState({required this.message});
}

class DeleteCommentLoadingState extends AddCommentsState {}

class DeleteCommentSuccessState extends AddCommentsState {
  // final bool isDeleted;
  // DeleteCommentSuccessState({required this.isDeleted});
}

class DeleteCommentErrorState extends AddCommentsState {
  final String message;
  DeleteCommentErrorState({required this.message});
}
