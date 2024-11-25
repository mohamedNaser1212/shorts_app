import 'package:dartz/dartz.dart';
import 'package:shorts/Features/comments_feature/domain/ccommeints_repo/comments_repo.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../../../videos_feature/domain/video_entity/video_entity.dart';
import '../../data/model/comments_model.dart';

class AddCommentsUseCase {
  final CommentsRepo commentsRepo;

  AddCommentsUseCase({required this.commentsRepo});

  Future<Either<Failure, CommentEntity>> addCommentToVideo({
    required CommentModel comment,
    required VideoEntity video,
  }) async {
    return await commentsRepo.addCommentToVideo(
      comment: comment,
      video: video,
    );
  }
}
