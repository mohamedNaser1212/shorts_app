import 'package:dartz/dartz.dart';
import 'package:shorts/Features/comments_feature/domain/ccommeints_repo/comments_repo.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../../../../core/managers/repo_manager/repo_manager.dart';
import '../../../videos_feature/domain/video_entity/video_entity.dart';
import '../data_sources/comments_remote_data_source.dart';
import '../model/comments_model.dart';

class CommentsRepoImpl extends CommentsRepo {
  final RepoManager repoManager;
  final CommentsRemoteDataSource commentsRemoteDataSource;

  CommentsRepoImpl({
    required this.repoManager,
    required this.commentsRemoteDataSource,
  });

  @override
  Future<Either<Failure, void>> addCommentToVideo({
    required String videoId,
    required CommentModel comment,
    required String userId,
    required VideoEntity video,
  }) async {
    return repoManager.call(
      action: () async {
        await commentsRemoteDataSource.addCommentToVideo(
          videoId: videoId,
          comment: comment,
          userId: userId,
          video: video,
        );
      },
    );
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getVideoComments({
    required String videoId,
  }) async {
    return repoManager.call(
      action: () async {
        final comments = await commentsRemoteDataSource.getComments(
          videoId: videoId,
        );
        return comments;
      },
    );
  }
}
