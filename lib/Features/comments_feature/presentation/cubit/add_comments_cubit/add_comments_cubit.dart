import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/data/model/comments_model.dart';
import 'package:shorts/Features/comments_feature/domain/comments_use_case/add_comments_use_case.dart';
import 'package:shorts/Features/comments_feature/domain/comments_use_case/delete_comment_use_case.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

part 'add_comments_state.dart';

class AddCommentsCubit extends Cubit<AddCommentsState> {
  AddCommentsCubit({
    required this.addCommentsUseCase,
    required this.deleteCommentUseCase,
  }) : super(AddCommentsState());
  final AddCommentsUseCase addCommentsUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;

  static AddCommentsCubit get(context) => BlocProvider.of(context);
  Future<void> addComment({
    required String comment,
    required UserEntity user,
    required VideoEntity video,
  }) async {
    emit(AddCommentsLoadingState());

    final result = await addCommentsUseCase.addCommentToVideo(
      comment: CommentModel(
        id: user.id!,
        content: comment,
        user: user,
        timestamp: DateTime.now(),
      ),
      video: video,
    );

    result.fold(
      (failure) {
        emit(AddCommentsErrorState(message: failure.message));
      },
      (success) {
        emit(AddCommentsSuccessState());
      },
    );
  }

  Future<void> deleteComment({
    required String userId,
    required String videoId,
    required String commentId,
  }) async {
    emit(DeleteCommentLoadingState());

    final result = await deleteCommentUseCase.deleteComment(
      userId: userId,
      videoId: videoId,
      commentId: commentId,
    );

    result.fold(
      (failure) {
        emit(DeleteCommentErrorState(message: failure.message));
      },
      (success) {
        print('Comment deleted successfully');
        emit(DeleteCommentSuccessState());
        // Fetch comments only if deletion was successful
        // CommentsCubit.get(context).getComments(videoId: videoId);
      },
    );
  }
}
