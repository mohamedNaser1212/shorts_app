import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/network/firebase_manager/collection_names.dart';
import '../../../videos_feature/domain/video_entity/video_entity.dart';
import '../model/comments_model.dart';

abstract class CommentsRemoteDataSource {
  Stream<List<CommentModel>> getComments(String videoId,
      {DocumentSnapshot? startAfter});
  Future<bool> addCommentToVideo({
    required String videoId,
    required CommentModel comment,
    required String userId,
    required VideoEntity video,
  });
}

class CommentsRemoteDataSourceImpl implements CommentsRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<List<CommentModel>> getComments(String videoId,
      {DocumentSnapshot? startAfter}) {
    Query query = firestore
        .collection(CollectionNames.videos)
        .doc(videoId)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .limit(20);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    return query.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => CommentModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }

  @override
  Future<bool> addCommentToVideo({
    required String videoId,
    required CommentModel comment,
    required String userId,
    required VideoEntity video,
  }) async {
    print('Adding comment to video with id: $videoId');

    final videoRef = firestore.collection(CollectionNames.videos).doc(videoId);

    final userVideoCommentsRef = firestore
        .collection(CollectionNames.users)
        .doc(video.user.id)
        .collection(CollectionNames.videos)
        .doc(videoId)
        .collection('comments');

    print('User ID: $userId');

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
  }
}
