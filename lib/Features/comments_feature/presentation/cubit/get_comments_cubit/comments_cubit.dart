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

  void getComments({
    required String videoId,
  }) async {
    if (cachedComments.containsKey(videoId)) {
      comments = cachedComments[videoId]!;
      emit(GetCommentsSuccessState(comments: comments));
      return;
    }

    emit(GetCommentsLoadingState());

    final result = await getCommentsUseCase.getVideoComments(videoId: videoId);
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
