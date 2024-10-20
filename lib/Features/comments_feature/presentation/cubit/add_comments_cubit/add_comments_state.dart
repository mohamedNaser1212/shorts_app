part of 'add_comments_cubit.dart';

 class AddCommentsState {}

class AddCommentsLoadingState extends AddCommentsState {}

class AddCommentsSuccessState extends AddCommentsState {}

class AddCommentsErrorState extends AddCommentsState {
  final String message;
  AddCommentsErrorState({required this.message});
}
