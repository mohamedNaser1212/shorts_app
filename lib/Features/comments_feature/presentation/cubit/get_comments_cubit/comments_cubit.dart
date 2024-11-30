import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/domain/comments_use_case/comments_count_use_case.dart';
import 'package:shorts/Features/comments_feature/domain/comments_use_case/show_comments_use_case.dart';

import '../../../domain/comments_entity/comments_entity.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit({
    required this.getCommentsUseCase,
    required this.getCommentsCountUseCase,
  }) : super(CommentsState());

  static CommentsCubit get(context) => BlocProvider.of(context);
  final GetCommentsUseCase getCommentsUseCase;
  final GetCommentsCountUseCase getCommentsCountUseCase;

  final Map<String, List<CommentEntity>> videoComments = {};
  final Map<String, bool> hasMoreCommentsForVideo = {};
  final Map<String, num> commentsCount = {};

  Future<void> getComments({
    required String videoId,
  }) async {
    // Check if comments already exist for this videoId and pagination is enabled
    if (videoComments.containsKey(videoId) &&
        !hasMoreCommentsForVideo[videoId]!) {
      emit(GetCommentsSuccessState(comments: videoComments[videoId]!));
      return;
    }

    final result = await getCommentsUseCase.getVideoComments(videoId: videoId);

    result.fold(
      (failure) => emit(GetCommentsErrorState(message: failure.message)),
      (fetchedComments) {
        final existingComments = videoComments[videoId] ?? [];

        final newComments = fetchedComments
            .where(
                (comment) => !existingComments.any((e) => e.id == comment.id))
            .toList();

        videoComments[videoId] = [
          ...existingComments,
          ...fetchedComments,
        ];

        // Update pagination flag
        hasMoreCommentsForVideo[videoId] = newComments.isNotEmpty;

        emit(GetCommentsSuccessState(comments: videoComments[videoId]!));
      },
    );
  }

  Future<num> getCommentsCount({required String videoId}) async {
    emit(GetCommentsCountLoadingState());

    final result =
        await getCommentsCountUseCase.getCommentsCount(videoId: videoId);
    result.fold(
      (failure) => emit(GetCommentsCountErrorState(message: failure.message)),
      (count) {
        commentsCount[videoId] = count;
        emit(GetCommentsCountSuccessState(commentsCount: count));
      },
    );

    return result.getOrElse(() => 0);
  }

  void reset() {
    videoComments.clear();
    hasMoreCommentsForVideo.clear();
    commentsCount.clear();
    emit(CommentsState());
  }
}
