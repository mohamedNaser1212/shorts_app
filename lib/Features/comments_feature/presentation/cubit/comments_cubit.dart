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

  final Map<String, List<CommentEntity>> _cachedComments = {};

  List<CommentEntity> comments = [];

  Future<void> addComment({
    required String comment,
    required UserEntity user,
    required VideoEntity video,
  }) async {
    emit(AddCommentsLoadingState());

    final result = await addCommentsUseCase.addCommentToVideo(
      comment: CommentModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: comment,
        user: user,
        timestamp: DateTime.now(),
      ),
      video: video,
    );

    result.fold(
      (failure) {
        emit(AddCommentsErrorState(message: failure.toString()));
      },
      (success) {
        _cachedComments.remove(video.id);
        getComments(videoId: video.id);
        emit(AddCommentsSuccessState());
      },
    );
  }

  void getComments({
    required String videoId,
  }) async {
    if (_cachedComments.containsKey(videoId)) {
      comments = _cachedComments[videoId]!;
      emit(GetCommentsSuccessState(comments: comments));
      return;
    }

    emit(GetCommentsLoadingState());

    final result = await getCommentsUseCase.getVideoComments(videoId: videoId);
    result.fold(
      (failure) => emit(GetCommentsErrorState(message: failure.toString())),
      (comments) {
        this.comments = comments;
        _cachedComments[videoId] = comments;
        emit(GetCommentsSuccessState(comments: comments));
      },
    );
  }
}
