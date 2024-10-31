import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/data/model/comments_model.dart';
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

  List<CommentEntity> comments = [];
  bool hasMoreComments = true;
  DocumentSnapshot? lastComment;
  bool isLastComment = false;
  Future<void> getComments({
    required String videoId,
    required int page,
  }) async {
    comments = [];
    FirebaseFirestore.instance
        .collection('videos')
        .doc(videoId)
        .collection('comments')
        .limit(7)
        .orderBy('timestamp', descending: true)
        .get()
        .then((value) {
      comments = [];
      for (var element in value.docs) {
        CommentModel currentComment = CommentModel.fromJson(element.data());
        currentComment.id = element.id;
        comments.add(currentComment);
      }
      if (value.docs.isNotEmpty) {
        lastComment = value.docs[value.docs.length - 1];
      }
      if (value.docs.length < 7) {
        isLastComment = true;
      }
      emit(GetCommentsSuccessState(
        comments: comments,
      ));
    }).catchError((error) {
      emit(GetCommentsErrorState(
        message: error.toString(),
      ));
    });
  }
  //   emit(GetCommentsLoadingState());

  //   final result = await getCommentsUseCase.getVideoComments(
  //     videoId: videoId,
  //     page: page,
  //   );

  //   result.fold(
  //     (failure) => emit(GetCommentsErrorState(message: failure.message)),
  //     (fetchedComments) {
  //       if (fetchedComments.length < 7) {
  //         hasMoreComments = false;
  //       }
  //       comments.addAll(fetchedComments.take(7));

  //       emit(GetCommentsSuccessState(comments: comments));
  //     },
  //   );
  // }

  Future<void> getStartAfterDocument(String videoId) async {
    FirebaseFirestore.instance
        .collection('videos')
        .doc(videoId)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .startAfterDocument(lastComment!)
        .limit(7) // Set to fetch only 7 comments
        .get()
        .then((value) {
      List<CommentModel> comments = [];
      for (var element in value.docs) {
        CommentModel commentModel = CommentModel.fromJson(element.data());
        commentModel.id = element.id;
        comments.add(commentModel);
      }

      lastComment = value.docs.isNotEmpty ? value.docs.last : null;
      if (value.docs.length < 7) {
        isLastComment = true;
      }
      emit(GetCommentsSuccessState(comments: comments));
    }).catchError((error) {
      emit(GetCommentsErrorState(message: error.toString()));
    });
  }

  num commentsCount = 0;

  Future<num> getCommentsCount({
    required String videoId,
  }) async {
    emit(GetCommentsCountLoadingState());

    final result =
        await getCommentsCountUseCase.getCommentsCount(videoId: videoId);
    result.fold(
      (failure) => emit(GetCommentsCountErrorState(message: failure.message)),
      (count) {
        commentsCount = count;
        emit(GetCommentsCountSuccessState(commentsCount: count));
      },
    );

    return commentsCount;
  }
}
