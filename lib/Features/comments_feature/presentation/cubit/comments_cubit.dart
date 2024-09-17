import 'package:dartz/dartz.dart'; // Import the Either type from dartz
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/domain/comments_use_case/add_comments_use_case.dart';
import 'package:shorts/Features/comments_feature/domain/comments_use_case/show_comments_use_case.dart';

import '../../../../core/error_manager/failure.dart';
import '../../../authentication_feature/data/user_model/user_model.dart';
import '../../data/model/comments_model.dart';
import '../../domain/comments_entity/comments_entity.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit({
    required this.addCommentsUseCase,
    required this.getCommentsUseCase,
  }) : super(CommentsState());

  static CommentsCubit get(context) => BlocProvider.of(context);

  final AddCommentsUseCase addCommentsUseCase;
  final GetCommentsUseCase getCommentsUseCase;

  Future<void> addComment({
    required String videoId,
    required String comment,
    required UserModel user,
  }) async {
    emit(AddCommentsLoadingState());
    try {
      final commentModel = CommentModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: comment,
        user: user,
        timestamp: DateTime.now(),
      );

      await addCommentsUseCase.addCommentToVideo(
        videoId: videoId,
        comment: commentModel,
      );
      emit(AddCommentsSuccessState());
    } catch (e) {
      emit(AddCommentsErrorState(message: e.toString()));
    }
  }

  Future<void> fetchComments({required String videoId}) async {
    emit(GetCommentsLoadingState());
    try {
      // Get the Either result
      final Either<Failure, List<CommentEntity>> result =
          await getCommentsUseCase.getVideoComments(videoId);

      result.fold(
        // Handle failure
        (failure) => emit(GetCommentsErrorState(message: failure.toString())),
        // Handle success
        (comments) => emit(GetCommentsSuccessState(comments: comments)),
      );
    } catch (e) {
      emit(GetCommentsErrorState(message: e.toString()));
    }
  }
}
