import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';
import '../../../videos_feature/domain/video_entity/video_entity.dart';
import '../model/comments_model.dart';

abstract class CommentsRemoteDataSource {
  Future<List<CommentModel>> getComments({
    required String videoId,
    required int page,
    int limit = 7,
  });

  Future<num> getCommentsCount({
    required String videoId,
  });

  Future<bool> addCommentToVideo({
    required CommentEntity comment,
    required VideoEntity video,
  });

  Future<bool> deleteComment({
    required String userId,
    required String videoId,
    required String commentId,
  });
}

class CommentsRemoteDataSourceImpl implements CommentsRemoteDataSource {
  final FirebaseHelper firebaseHelper;

  const CommentsRemoteDataSourceImpl({
    required this.firebaseHelper,
  });

  @override
  Future<List<CommentModel>> getComments({
    required String videoId,
    required int page,
    int limit = 7,
  }) async {
    // final startAfter = (page > 1)
    //     ? await _getStartAfterDocument(videoId, (page ) * limit)
    //     : null;

    final commentsData = await firebaseHelper.getCollectionDocuments(
      collectionPath: 'videos',
      docId: videoId,
      subCollectionPath: 'comments',
      limit: limit,
      orderBy: 'timestamp',
      descending: true,
      // startAfter: startAfter as DocumentSnapshot<Map<String, dynamic>>?,
    );

    return commentsData.map((data) => CommentModel.fromJson(data)).toList();
  }

// Future<DocumentReference<Map<String, dynamic>>?> _getStartAfterDocument(
//   String videoId,
//   int offset,
// ) async {
//   final commentsSnapshot = await firebaseHelper.getCollectionDocuments(
//     collectionPath: 'videos',
//     docId: videoId,
//     subCollectionPath: 'comments',
//     limit: offset,
//     orderBy: 'timestamp',
//     descending: true,
//   );

//   return commentsSnapshot.isNotEmpty
//       ? FirebaseFirestore.instance
//           .collection('videos')
//           .doc(videoId)
//           .collection('comments')
//           .doc(commentsSnapshot.last['id'])
//       : null;
// }
  @override
  Future<num> getCommentsCount({
    required String videoId,
  }) async {
    final commentsData = await firebaseHelper.getCollectionDocuments(
      collectionPath: 'videos',
      docId: videoId,
      subCollectionPath: 'comments',
    );

    return commentsData.length;
  }

  @override
  Future<bool> addCommentToVideo({
    required CommentEntity comment,
    required VideoEntity video,
  }) async {
    // Add the comment to the video comments sub-collection
    await firebaseHelper.addDocumentWithAutoId(
      collectionPath: 'videos',
      data: comment.toJson(),
      docId: video.id,
      subCollectionPath: 'comments',
    );

    // Add the comment to the user's comments sub-collection
    await firebaseHelper.addDocumentWithAutoId(
      collectionPath: 'users',
      data: comment.toJson(),
      docId: video.user.id,
      subCollectionPath: 'videos/${video.id}/comments',
    );

    return true;
  }

  @override
  Future<bool> deleteComment({
    required String userId,
    required String videoId,
    required String commentId,
  }) async {
    await firebaseHelper.deleteDocument(
      collectionPath: 'videos',
      docId: videoId,
      subCollectionPath: 'comments',
      subDocId: commentId,
    );

    await firebaseHelper.deleteDocument(
      collectionPath: 'users',
      docId: userId,
      subCollectionPath: 'videos/$videoId/comments',
      subDocId: commentId,
    );

    return true;
  }
}
