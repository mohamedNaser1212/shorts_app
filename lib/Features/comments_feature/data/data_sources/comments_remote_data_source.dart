import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';

import '../../../videos_feature/domain/video_entity/video_entity.dart';
import '../model/comments_model.dart';

abstract class CommentsRemoteDataSource {
  Future<List<CommentModel>> getComments({
    required String videoId,
  });

  Future<num> getCommentsCount({
    required String videoId,
  });

  Future<List<CommentModel>> addCommentToVideo({
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
    // bool hasMoreComments = true;

    Query commentsQuery = FirebaseFirestore.instance
        .collection('videos')
        .doc(videoId)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .limit(limit);

    if (lastComments[videoId] != null) {
      commentsQuery = commentsQuery.startAfterDocument(lastComments[videoId]!);
    }

    final querySnapshot = await commentsQuery.get();

    if (querySnapshot.docs.isEmpty) {
      return comments;
    }
    List<CommentModel> fetchedComments = querySnapshot.docs.map((doc) {
      CommentModel comment =
          CommentModel.fromJson(doc.data() as Map<String, dynamic>);
      comment.id = doc.id;
      return comment;
    }).toList();
    lastComments[videoId] = querySnapshot.docs.last;
    comments.addAll(fetchedComments);
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
  Future<List<CommentModel>> addCommentToVideo({
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

    return [];
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
