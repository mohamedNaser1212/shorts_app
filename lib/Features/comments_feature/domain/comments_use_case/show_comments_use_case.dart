import 'package:dartz/dartz.dart';
import 'package:shorts/Features/comments_feature/domain/ccommeints_repo/comments_repo.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../comments_entity/comments_entity.dart';
class GetCommentsUseCase {
  final CommentsRepo commentsRepo;

  GetCommentsUseCase({required this.commentsRepo});

  Future<Either<Failure, List<CommentEntity>>> getVideoComments({
    required String videoId,
    required int page,
    int limit = 20, // default limit for comments per page
  }) async {
    return await commentsRepo.getVideoComments(
      videoId: videoId,
      page: page,
      limit: limit,
    );
  }
}
