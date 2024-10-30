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

  final Map<String, List<CommentEntity>> cachedComments = {};

  List<CommentEntity> comments = [];
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shorts/Features/comments_feature/domain/comments_use_case/comments_count_use_case.dart';
// import 'package:shorts/Features/comments_feature/domain/comments_use_case/show_comments_use_case.dart';
// import '../../../domain/comments_entity/comments_entity.dart';

// part 'comments_state.dart';
// class CommentsCubit extends Cubit<CommentsState> {
//   final GetCommentsUseCase getCommentsUseCase;
//   final GetCommentsCountUseCase getCommentsCountUseCase;

//   CommentsCubit({
//     required this.getCommentsUseCase,
//     required this.getCommentsCountUseCase,
//   }) : super(CommentsState());

//   static CommentsCubit get(context) => BlocProvider.of(context);

//   List<CommentEntity> comments = [];

//   void getComments({
//     required String videoId,
//     required int page,
//     int limit = 7,
//   }) async {
//     final offset = (page - 1) * limit;
    
//     emit(GetCommentsLoadingState());

//     final result = await getCommentsUseCase.getVideoComments(
//       videoId: videoId,
//       page: page,
//       limit: limit,
//     );
//     result.fold(
//       (failure) => emit(GetCommentsErrorState(message: failure.toString())),
//       (newComments) {
//         comments = [...comments, ...newComments];
//         emit(GetCommentsSuccessState(comments: newComments));
//       },
//     );
//   }



  void getComments({
    required String videoId,
    required int page,
    int limit = 7, // default limit for comments per page
  }) async {
    final offset = (page - 1) * limit; // Calculate offset based on the current page

    if (cachedComments.containsKey(videoId) &&
        cachedComments[videoId]!.length > offset) {
      // If we already have comments cached, return the required page
      comments = cachedComments[videoId]!.skip(offset).take(limit).toList();
      emit(GetCommentsSuccessState(comments: comments));
      return;
    }

    emit(GetCommentsLoadingState());

    final result = await getCommentsUseCase.getVideoComments(videoId: videoId, page: page, limit: limit);
    result.fold(
      (failure) => emit(GetCommentsErrorState(message: failure.toString())),
      (comments) {
        this.comments = comments;
        cachedComments[videoId] = comments;
        getCommentsCount(videoId: videoId);
        emit(GetCommentsSuccessState(comments: comments));
      },
    );
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

        print('commentsCount: $commentsCount');

        emit(GetCommentsCountSuccessState(
          commentsCount: count,
        ));
      },
    );

    return commentsCount;
  }
}
