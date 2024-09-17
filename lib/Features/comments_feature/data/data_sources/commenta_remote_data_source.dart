import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/consts.dart';
import '../../../../core/network/firebase_manager/collection_names.dart';
import '../model/comments_model.dart';

abstract class CommentsRemoteDataSource {
  Future<List<CommentModel>> getVideoComments(String videoId);
  Future<bool> addCommentToVideo({
    required String videoId,
    required CommentModel comment,
  });
}

class CommentsRemoteDataSourceImpl implements CommentsRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<CommentModel>> getVideoComments(String videoId) async {
    final querySnapshot = await firestore
        .collection(CollectionNames.videos)
        .doc(videoId)
        .collection('comments')
        .get();

    return querySnapshot.docs
        .map((doc) => CommentModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<bool> addCommentToVideo({
    required String videoId,
    required CommentModel comment,
  }) async {
    try {
      final videoRef =
          firestore.collection(CollectionNames.videos).doc(videoId);

      final userVideoCommentsRef = firestore
          .collection(CollectionNames.users)
          .doc(comment.user.id)
          .collection(CollectionNames.videos)
          .doc(videoId)
          .collection('comments');
      print(uId);

      final videoDoc = await videoRef.get();

      if (videoDoc.exists) {
        await videoRef
            .collection('comments')
            .doc(comment.id)
            .set(comment.toJson());

        await userVideoCommentsRef.doc(comment.id).set(comment.toJson());

        print(
            'Comment added to both video and user\'s video comments collection');
        return true;
      } else {
        print('Video not found in collection');
        return false;
      }
    } catch (e) {
      print('Error adding comment: $e');
      return false;
    }
  }
}
