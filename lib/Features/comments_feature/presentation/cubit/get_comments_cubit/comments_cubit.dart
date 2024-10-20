import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/domain/comments_use_case/show_comments_use_case.dart';
import '../../../domain/comments_entity/comments_entity.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit({
    required this.getCommentsUseCase,
  }) : super(CommentsState());

  static CommentsCubit get(context) => BlocProvider.of(context);

  final GetCommentsUseCase getCommentsUseCase;

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
        emit(GetCommentsSuccessState(comments: comments));
      },
    );
  }
}
