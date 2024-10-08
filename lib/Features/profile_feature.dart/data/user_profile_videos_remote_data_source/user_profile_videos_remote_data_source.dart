import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';

abstract class UserProfileVideosRemoteDataSource {
  Future<List<VideoModel>> getUserVideos({required String userId});
}

class UserProfileVideosRemoteDataSourceImpl
    extends UserProfileVideosRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<VideoModel>> getUserVideos({required String userId}) async {
    // Access the user's videos collection
    final querySnapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('videos') 
        .get();

    // Map the documents to VideoModel
    return querySnapshot.docs
        .map((doc) => VideoModel.fromJson(doc.data()))
        .toList();
  }
}
