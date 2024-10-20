import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/data/model/comments_model.dart';
import 'package:shorts/Features/comments_feature/domain/comments_use_case/add_comments_use_case.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

part 'add_comments_state.dart';

class AddCommentsCubit extends Cubit<AddCommentsState> {
  AddCommentsCubit({
    required this.addCommentsUseCase,
  }) : super(AddCommentsState());
  final AddCommentsUseCase addCommentsUseCase;

  static AddCommentsCubit get(context) => BlocProvider.of(context);
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
        emit(AddCommentsSuccessState());
      },
    );
  }
}
