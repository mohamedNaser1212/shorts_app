import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';
import '../../../videos_feature/domain/video_entity/video_entity.dart';
import '../model/comments_model.dart';

abstract class CommentsRemoteDataSource {
  Future<List<CommentModel>> getComments({
    required String videoId,
    required int page,
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

  CommentsRemoteDataSourceImpl({
    required this.firebaseHelper,
  });

  List<CommentModel> comments = [];
  DocumentSnapshot? lastComment;
  bool hasMoreComments = true;
  final int limit = 7;

  @override
  Future<List<CommentModel>> getComments({
    required String videoId,
    required int page,
  }) async {
    comments = [];
    // If there are no more comments to fetch, return the existing list
    if (!hasMoreComments) return comments;

    // Set the limit of comments to fetch per page
    int currentLimit = 7;

    // Create the query for fetching comments
    Query commentsQuery = FirebaseFirestore.instance
        .collection('videos')
        .doc(videoId)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .limit(currentLimit);

    // Apply pagination if we are not on the first page
    if (page > 0 && lastComment != null) {
      commentsQuery = commentsQuery.startAfterDocument(lastComment!);
    }

    // Fetch the comments from Firestore
    final querySnapshot = await commentsQuery.get();


    if (querySnapshot.docs.isEmpty) {     
      hasMoreComments = false;
      return comments;
    }


    List<CommentModel> fetchedComments = querySnapshot.docs.map((doc) {
      CommentModel comment =
          CommentModel.fromJson(doc.data() as Map<String, dynamic>);
      comment.id = doc.id;
      return comment;
    }).toList();

    // Update the last fetched comment for paginationA
    lastComment = querySnapshot.docs.last;

    if(lastComment == null){
      hasMoreComments = false;

      return comments;
    }

    // Append only new comments to avoid duplicates
     comments=[];
    for (var newComment in fetchedComments) {
      if (!comments.any((c) => c.id == newComment.id)) {
        comments.add(newComment);
      }
    }

    // If fetched comments are less than the limit, mark no more comments are left
    if (fetchedComments.length < currentLimit) {
      hasMoreComments = false;
    }
    print('comments: ${comments.length}');

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
