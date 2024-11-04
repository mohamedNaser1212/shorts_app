import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../comments_entity/comments_entity.dart';

abstract class CommentsRepo {
  const CommentsRepo();
  Future<Either<Failure, List<CommentEntity>>> getVideoComments({
      required String videoId,
    required int page,
  });
    Future<Either<Failure,  DocumentSnapshot?>> getStartAfterDocument(
    {
      required String videoId
    }
  );
  Future<Either<Failure, List<CommentEntity>>> addCommentToVideo({
    required CommentEntity comment,
    required VideoEntity video,
  });
  
  Future<Either<Failure, num>> getCommentsCount({
    required String videoId,
  });

  Future<Either<Failure, bool>> deleteComment({
    required String userId,
    required String videoId,
    required String commentId,
  });
}
