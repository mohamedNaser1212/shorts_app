part of 'comments_cubit.dart';

class CommentsState {}


class GetCommentsLoadingState extends CommentsState {}

class GetCommentsSuccessState extends CommentsState {
  final List<CommentEntity> comments;
  GetCommentsSuccessState({required this.comments});
}

class GetCommentsErrorState extends CommentsState {
  final String message;
  GetCommentsErrorState({required this.message});
}
