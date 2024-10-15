import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/firebase_helper.dart';
import '../../../videos_feature/domain/video_entity/video_entity.dart';
import '../model/comments_model.dart';

abstract class CommentsRemoteDataSource {
  Future<List<CommentModel>> getComments({
    required String videoId,
  });
  Future<bool> addCommentToVideo({
    required CommentEntity comment,
    required VideoEntity video,
  });
}
class CommentsRemoteDataSourceImpl implements CommentsRemoteDataSource {
  final FirebaseHelperManager firebaseHelper;

 const CommentsRemoteDataSourceImpl({
    required this.firebaseHelper,
  });

  @override
  Future<List<CommentModel>> getComments({
    required String videoId,
  }) async {
    final commentsData = await firebaseHelper.getCollectionDocuments(
      collectionPath: 'videos',
      docId: videoId,
      subCollectionPath: 'comments',
      limit: 20,
      orderBy: 'timestamp',
      descending: true,
    );

    return commentsData.map((data) => CommentModel.fromJson(data)).toList();
  }

  @override
  Future<bool> addCommentToVideo({
    required CommentEntity comment,
    required VideoEntity video,
  }) async {
    final videoData = await firebaseHelper.getDocument(
      collectionPath: 'videos',
      docId: video.id,
    );

    if (videoData != null) {
      await firebaseHelper.addDocument(
        collectionPath: 'videos',
        docId: video.id,
        subCollectionPath: 'comments',
        data: comment.toJson(),
      );

      await firebaseHelper.addDocument(
        collectionPath: 'users',
        docId: video.user.id,
        subCollectionPath: 'videos/${video.id}/comments',
        data: comment.toJson(),
      );

      return true;
    }
    return false;
  }
}