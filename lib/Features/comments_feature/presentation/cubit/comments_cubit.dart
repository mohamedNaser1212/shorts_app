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

  Future<void> addComment({
    required String videoId,
    required String comment,
    required UserEntity user,
    required String userId,
    required VideoEntity video,
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
        userId: userId,
        video: video,
      );
      emit(AddCommentsSuccessState());
    } catch (e) {
      emit(AddCommentsErrorState(message: e.toString()));
    }
  }

  List<CommentEntity> comments = [];

  Future<void> fetchComments({required String videoId}) async {
    emit(GetCommentsLoadingState());

    var result = await getCommentsUseCase.getVideoComments(videoId);

    result.fold(
      (failure) => emit(GetCommentsErrorState(message: failure.toString())),
      (comments) {
        this.comments = comments;
        print('Comments: ${comments.length}');
        emit(GetCommentsSuccessState(comments: comments));
      },
    );
  }
}
