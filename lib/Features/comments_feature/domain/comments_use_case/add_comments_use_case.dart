import 'package:dartz/dartz.dart';
import 'package:shorts/Features/comments_feature/domain/ccommeints_repo/comments_repo.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../../../videos_feature/domain/video_entity/video_entity.dart';
import '../../data/model/comments_model.dart';

class AddCommentsUseCase {
  final CommentsRepo commentsRepo;

  AddCommentsUseCase({required this.commentsRepo});

  Future<Either<Failure, void>> addCommentToVideo({
    required String videoId,
    required CommentModel comment,
    required String userId,
    required VideoEntity video,
  }) async {
    return await commentsRepo.addCommentToVideo(
      videoId: videoId,
      comment: comment,
      userId: userId,
      video: video,
    );
  }
}
