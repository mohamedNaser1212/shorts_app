import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';

import '../../../videos_feature/domain/video_entity/video_entity.dart';
import '../../domain/comments_entity/comments_entity.dart';
import '../model/comments_model.dart';

abstract class CommentsRemoteDataSource {
  Future<List<CommentModel>> getComments({
    required String videoId,
  });

  Future<num> getCommentsCount({
    required String videoId,
  });

  Future<CommentEntity> addCommentToVideo({
    required CommentModel comment,
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

  CommentsRemoteDataSourceImpl({
    required this.firebaseHelper,
  });

  final Map<String, DocumentSnapshot?> lastComments = {};
  final int limit = 7;

  @override
  Future<List<CommentModel>> getComments({
    required String videoId,
  }) async {
    List<CommentModel> comments = [];

    // Reference to the comments sub-collection.
    final query = FirebaseFirestore.instance
        .collection('videos')
        .doc(videoId)
        .collection('comments')
        .orderBy('timestamp', descending: true);

    QuerySnapshot<Map<String, dynamic>> fetchedComments;

    if (lastComments[videoId] != null) {
      fetchedComments = await query
          .startAfterDocument(lastComments[videoId]!)
          .limit(limit)
          .get();
    } else {
      fetchedComments = await query.limit(limit).get();
    }

    // Map the fetched Firestore documents to CommentModel instances.
    comments = fetchedComments.docs.map((doc) {
      return CommentModel.fromJson(doc.data());
    }).toList();

    // Update the last fetched document for pagination.
    if (fetchedComments.docs.isNotEmpty) {
      lastComments[videoId] = fetchedComments.docs.last;
    }
    print('fetched comments${comments.length}');

    return comments;
  }

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
  Future<CommentEntity> addCommentToVideo({
    required CommentModel comment,
    required VideoEntity video,
  }) async {
    await firebaseHelper.addDocumentWithAutoId(
      collectionPath: 'videos',
      data: comment.toJson(),
      docId: video.id,
      subCollectionPath: 'comments',
    );

    await firebaseHelper.addDocumentWithAutoId(
      collectionPath: 'users',
      data: comment.toJson(),
      docId: video.user.id,
      subCollectionPath: 'videos/${video.id}/comments',
    );

    return comment;
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
