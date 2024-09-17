import 'package:dartz/dartz.dart';

import '../../../../core/error_manager/failure.dart';
import '../../data/model/comments_model.dart';
import '../comments_entity/comments_entity.dart';

abstract class CommentsRepo {
  Future<Either<Failure, List<CommentEntity>>> getVideoComments(String videoId);
  Future<Either<Failure, void>> addCommentToVideo({
    required String videoId,
    required CommentModel comment,
  });
}
