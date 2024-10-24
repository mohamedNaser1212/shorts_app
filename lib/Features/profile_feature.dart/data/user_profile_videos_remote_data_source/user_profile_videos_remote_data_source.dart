import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';

abstract class UserProfileVideosRemoteDataSource {
  Future<List<VideoModel>> getUserVideos({required String userId});
}

class UserProfileVideosRemoteDataSourceImpl
    extends UserProfileVideosRemoteDataSource {
  final FirebaseHelper firebaseHelper;

  UserProfileVideosRemoteDataSourceImpl({required this.firebaseHelper});

  @override
  Future<List<VideoModel>> getUserVideos({required String userId}) async {
    final querySnapshot = await firebaseHelper.getCollectionDocuments(
      collectionPath: 'users/$userId/videos',
    );

    return querySnapshot.map((doc) => VideoModel.fromJson(doc)).toList();
  }
}
