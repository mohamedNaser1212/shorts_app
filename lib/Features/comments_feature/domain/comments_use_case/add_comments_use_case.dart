import 'package:dartz/dartz.dart';
import 'package:shorts/Features/comments_feature/domain/ccommeints_repo/comments_repo.dart';

import '../../../../core/error_manager/failure.dart';
import '../../data/model/comments_model.dart';

class AddCommentsUseCase {
  final CommentsRepo commentsRepo;

  AddCommentsUseCase({required this.commentsRepo});

  Future<Either<Failure, void>> addCommentToVideo({
    required String videoId,
    required CommentModel comment,
  }) async {
    return await commentsRepo.addCommentToVideo(
        videoId: videoId, comment: comment);
  }
}
