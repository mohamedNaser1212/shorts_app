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
    final result = await getCommentsUseCase.getVideoComments(
      videoId: videoId,
    );

    result.fold(
      (failure) {
        emit(GetCommentsErrorState(message: failure.message));
      },
      (fetchedComments) {
        hasMoreCommentsForVideo[videoId] = fetchedComments.isNotEmpty &&
            (videoComments[videoId]?.length ?? 0) < commentsCount[videoId]!;
        final existingComments = videoComments[videoId] ?? [];

        videoComments[videoId] = [
          ...existingComments,
        ];

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

// Updated `CommentsBottomSheetState`
