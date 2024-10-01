import 'package:dartz/dartz.dart';
import 'package:shorts/Features/comments_feature/data/data_sources/comments_local_data_source.dart';
import 'package:shorts/Features/comments_feature/data/data_sources/comments_remote_data_source.dart';
import 'package:shorts/Features/comments_feature/domain/ccommeints_repo/comments_repo.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import '../../../../core/managers/error_manager/failure.dart';
import '../../../../core/managers/repo_manager/repo_manager.dart';
import '../../../videos_feature/domain/video_entity/video_entity.dart';

class CommentsRepoImpl implements CommentsRepo {
  final RepoManager repoManager;
  final CommentsRemoteDataSource commentsRemoteDataSource;
  final CommentsLocalDataSource commentsLocalDataSource;

  CommentsRepoImpl({
    required this.repoManager,
    required this.commentsRemoteDataSource,
    required this.commentsLocalDataSource,
  });

  @override
  Future<Either<Failure, List<CommentEntity>>> addCommentToVideo({
    required String videoId,
    required CommentEntity comment,
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

        // Update cache with new comment
        final comments = await commentsLocalDataSource.getComments();
        comments.add(comment);
        await commentsLocalDataSource.saveComments(comments);
        return comments;
      },
    );
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getVideoComments({
    required String videoId,
  }) async {
    return repoManager.call(
      action: () async {
        // Check cache first
        final cachedComments = await commentsLocalDataSource.getComments();
        if (cachedComments.isNotEmpty) {
          // Return cached comments if available
          return cachedComments;
        } else {
          // Fetch from remote source if cache is empty
          final comments = await commentsRemoteDataSource.getComments(videoId: videoId);
          await commentsLocalDataSource.saveComments(comments);
          return comments;
        }
      },
    );
  }
}
