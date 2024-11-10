import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';

abstract class UserProfilesRemoteDataSource {
  Future<List<VideoModel>> getUserVideos({
    required String userId,
  });
  Future<void> followUser({
    required String currentUserId,
    required String targetUserId,
  });
  Future<void> unfollowUser({
    required String currentUserId,
    required String targetUserId,
  });
  Future<int> getFollowersCount({
    required String userId,
  });
  Future<int> getFollowingCount({
    required String userId,
  });
}

class UserProfileVideosRemoteDataSourceImpl
    extends UserProfilesRemoteDataSource {
  final FirebaseHelper firebaseHelper;

  UserProfileVideosRemoteDataSourceImpl({required this.firebaseHelper});

  @override
  Future<List<VideoModel>> getUserVideos({required String userId}) async {
    final querySnapshot = await firebaseHelper.getCollectionDocuments(
      collectionPath: 'users/$userId/videos',
    );

    return querySnapshot.map((doc) => VideoModel.fromJson(doc)).toList();
  }

  @override
  Future<void> followUser({
    required String currentUserId,
    required String targetUserId,
  }) async {
    await firebaseHelper.addDocument(
      collectionPath: 'users/$currentUserId/following',
      docId: targetUserId,
      data: {'followedAt': DateTime.now().toIso8601String()},
    );

    await firebaseHelper.addDocument(
      collectionPath: 'users/$targetUserId/followers',
      docId: currentUserId,
      data: {'followedAt': DateTime.now().toIso8601String()},
    );
  }

  @override
  Future<void> unfollowUser(
      {required String currentUserId, required String targetUserId}) async {
    await firebaseHelper.deleteDocument(
      collectionPath: 'users/$currentUserId/following',
      docId: targetUserId,
    );

    await firebaseHelper.deleteDocument(
      collectionPath: 'users/$targetUserId/followers',
      docId: currentUserId,
    );
  }

  @override
  Future<int> getFollowersCount({
    required String userId,
  }) async {
    final followersSnapshot = await firebaseHelper.getCollectionDocuments(
      collectionPath: 'users/$userId/followers',
    );
    return followersSnapshot.length;
  }

  @override
  Future<int> getFollowingCount({
    required String userId,
  }) async {
    final followingSnapshot = await firebaseHelper.getCollectionDocuments(
      collectionPath: 'users/$userId/following',
    );
    return followingSnapshot.length;
  }
}
