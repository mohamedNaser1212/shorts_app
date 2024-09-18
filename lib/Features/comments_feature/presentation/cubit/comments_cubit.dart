import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/domain/comments_use_case/add_comments_use_case.dart';
import 'package:shorts/Features/comments_feature/domain/comments_use_case/show_comments_use_case.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

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

  // Maintain a list of comments locally with CommentModel type
  List<CommentEntity> comments = [];

  Future<void> addComment({
    required String videoId,
    required String comment,
    required UserEntity user,
    required String userId,
    required VideoEntity video,
  }) async {
    emit(AddCommentsLoadingState());
    // //
    // final commentModel = CommentModel(
    //   id: DateTime.now().millisecondsSinceEpoch.toString(),
    //   content: comment,
    //   user: user,
    //   timestamp: DateTime.now(),
    // );

    emit(GetCommentsSuccessState(comments: comments));

    final result = await addCommentsUseCase.addCommentToVideo(
      videoId: videoId,
      comment: CommentModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: comment,
        user: user,
        timestamp: DateTime.now(),
      ),
      userId: userId,
      video: video,
    );
    result.fold(
      (failure) => emit(AddCommentsErrorState(message: failure.toString())),
      (success) {
        startListeningToComments(videoId);

        emit(AddCommentsSuccessState());
      },
    );
  }

  void startListeningToComments(String videoId) async {
    emit(GetCommentsLoadingState());

    final result = await getCommentsUseCase.getVideoComments(videoId);
    result.fold(
      (failure) => emit(GetCommentsErrorState(message: failure.toString())),
      (comments) {
        this.comments = comments; // Update the local comments list
        emit(GetCommentsSuccessState(comments: comments));
      },
    );
  }
}
