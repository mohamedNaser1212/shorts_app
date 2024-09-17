part of 'comments_cubit.dart';

class CommentsState {}

class AddCommentsLoadingState extends CommentsState {}

class AddCommentsSuccessState extends CommentsState {}

class AddCommentsErrorState extends CommentsState {
  final String message;
  AddCommentsErrorState({required this.message});
}

class GetCommentsLoadingState extends CommentsState {}

class GetCommentsSuccessState extends CommentsState {
  final List<CommentEntity> comments;
  GetCommentsSuccessState({required this.comments});
}

class GetCommentsErrorState extends CommentsState {
  final String message;
  GetCommentsErrorState({required this.message});
}
