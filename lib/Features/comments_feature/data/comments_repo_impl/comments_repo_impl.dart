import 'package:dartz/dartz.dart';
import 'package:shorts/Features/comments_feature/domain/ccommeints_repo/comments_repo.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/core/error_manager/failure.dart';
import 'package:shorts/core/repo_manager/repo_manager.dart';

import '../data_sources/commenta_remote_data_source.dart';
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
  }) async {
    return repoManager.call(
      action: () async {
        await commentsRemoteDataSource.addCommentToVideo(
          videoId: videoId,
          comment: comment,
        );
      },
    );
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getVideoComments(
      String videoId) async {
    return repoManager.call(
      action: () async {
        final comments =
            await commentsRemoteDataSource.getVideoComments(videoId);
        return comments;
      },
    );
  }
}
