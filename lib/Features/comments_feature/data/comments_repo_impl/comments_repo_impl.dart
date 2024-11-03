import 'package:cloud_firestore/cloud_firestore.dart';
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
    required CommentEntity comment,
    required VideoEntity video,
  }) async {
    return repoManager.call(
      action: () async {
        await commentsRemoteDataSource.addCommentToVideo(
          comment: comment,
          video: video,
        );

        final comments = await commentsLocalDataSource.getComments(
          videoId: video.id,
        );
        // comments.add(comment);
        await commentsLocalDataSource.saveComments(comments);
        return comments;
      },
    );
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getVideoComments({
    required String videoId,
    required int page,
  }) async {
    return repoManager.call(
      action: () async {
        final comments = await commentsRemoteDataSource.getComments(
          videoId: videoId,
         page: page,
        );
        await commentsLocalDataSource.saveComments(comments);
        return comments;
      },
    );
  }

  @override
  Future<Either<Failure, num>> getCommentsCount({
    required String videoId,
  }) async {
    return repoManager.call(
      action: () async {
        final commentsCount =
            await commentsRemoteDataSource.getCommentsCount(videoId: videoId);
        return commentsCount;
      },
    );
  }

  @override
  Future<Either<Failure, bool>> deleteComment({
    required String userId,
    required String videoId,
    required String commentId,
  }) async {
    return repoManager.call(
      action: () async {
        final success = await commentsRemoteDataSource.deleteComment(
          userId: userId,
          videoId: videoId,
          commentId: commentId,
        );
        print('success: $success');
        return success;
      },
    );
  }
  
  @override
  Future<Either<Failure,  DocumentSnapshot?>> getStartAfterDocument({required String videoId}) {

    return repoManager.call(
      action: () async { 
      //  final success = await commentsRemoteDataSource.getStartAfterDocument(
      //     videoId: videoId,
      //   );
      //   return success;
      },);
   
  }
}
