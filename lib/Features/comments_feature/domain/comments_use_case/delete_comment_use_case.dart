import 'package:dartz/dartz.dart';
import 'package:shorts/Features/comments_feature/domain/ccommeints_repo/comments_repo.dart';

import '../../../../core/managers/error_manager/failure.dart';

class DeleteCommentUseCase {
  final CommentsRepo commentsRepo;

  DeleteCommentUseCase({required this.commentsRepo});

  Future<Either<Failure, bool>> deleteComment({
        required String userId,
    required String videoId,
    required String commentId,
  }) async {
    return await commentsRepo.deleteComment(
      userId: userId,
      videoId: videoId,
      commentId: commentId,
    );
  }
}
