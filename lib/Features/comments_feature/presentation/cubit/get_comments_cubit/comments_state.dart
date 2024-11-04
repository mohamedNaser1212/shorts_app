part of 'comments_cubit.dart';

class CommentsState {}


class GetCommentsLoadingState extends CommentsState {}

class GetCommentsSuccessState extends CommentsState {
  final List<CommentEntity>? comments;
  GetCommentsSuccessState({ this.comments});
}

class GetCommentsErrorState extends CommentsState {
  final String message;
  GetCommentsErrorState({required this.message});
}
class GetCommentsCountLoadingState extends CommentsState {}

class GetCommentsCountSuccessState extends CommentsState {
  final num commentsCount;
  GetCommentsCountSuccessState({required this.commentsCount});
}

class GetCommentsCountErrorState extends CommentsState {
  final String message;
  GetCommentsCountErrorState({required this.message});
}
