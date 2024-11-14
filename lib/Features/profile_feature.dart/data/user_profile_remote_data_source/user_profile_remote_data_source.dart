import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts/Features/authentication_feature/data/user_model/user_model.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';

import '../../../../core/network/firebase_manager/collection_names.dart';
import '../../../../core/utils/constants/request_data_names.dart';

abstract class UserProfilesRemoteDataSource {
  Future<List<VideoModel>> getUserVideos({
    required String userId,
    int pageSize = 6,
  });
  Future<UserModel> toggleFollow({
    required String currentUserId,
    required String targetUserId,
  });
  Future<int> getFollowersCount({
    required String userId,
  });
  Future<int> getFollowingCount({
    required String userId,
  });
  Future<bool> isUserFollowed({
    required String currentUserId,
    required String targetUserId,
  });
}

class UserProfileVideosRemoteDataSourceImpl extends UserProfilesRemoteDataSource {
  final FirebaseHelper firebaseHelper;
  DocumentSnapshot? _lastDocument;
  static const int _defaultPageSize = 6;
  bool hasMoreVideos = true;
  final int limit = _defaultPageSize;

  UserProfileVideosRemoteDataSourceImpl({required this.firebaseHelper});

  void resetPagination() {
    _lastDocument = null;
    hasMoreVideos = true;
  }

  @override
  Future<List<VideoModel>> getUserVideos({
    required String userId,
    int pageSize = _defaultPageSize,
  }) async {
    if (!hasMoreVideos) {
      resetPagination();
    }

    final querySnapshot = await firebaseHelper.getCollectionQuerySnapshot(
      collectionPath: '${CollectionNames.users}/$userId/${CollectionNames.videos}',
      orderBy: RequestDataNames.timeStamp,
      descending: true,
      limit: limit,
      startAfter: _lastDocument,
    );

    if (querySnapshot.docs.isEmpty) {
      hasMoreVideos = false;
      return [];
    }

    final videos = querySnapshot.docs
        .map((doc) => VideoModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    _lastDocument = querySnapshot.docs.last;

    if (videos.length < limit) {
      hasMoreVideos = false;
    }

    return videos;
  }

  @override
  Future<UserModel> toggleFollow({
    required String currentUserId,
    required String targetUserId,
  }) async {
    final currentUserDocPath = '${CollectionNames.users}/$currentUserId';
    final targetUserDocPath = '${CollectionNames.users}/$targetUserId';

    final isFollowing = await firebaseHelper.getDocument(
      collectionPath: '$currentUserDocPath/${CollectionNames.following}',
      docId: targetUserId,
    ) != null;

    if (isFollowing) {
      await firebaseHelper.deleteDocument(
        collectionPath: '$currentUserDocPath/${CollectionNames.following}',
        docId: targetUserId,
      );
      await firebaseHelper.deleteDocument(
        collectionPath: '$targetUserDocPath/${CollectionNames.followers}',
        docId: currentUserId,
      );

      await firebaseHelper.updateDocument(
        collectionPath: currentUserDocPath,
        docId: currentUserId,
        data: {RequestDataNames.followingCount: FieldValue.increment(-1)},
      );
      await firebaseHelper.updateDocument(
        collectionPath: targetUserDocPath,
        docId: targetUserId,
        data: {RequestDataNames.followersCount: FieldValue.increment(-1)},
      );
    } else {
      await firebaseHelper.addDocument(
        collectionPath: '$currentUserDocPath/${CollectionNames.following}',
        docId: targetUserId,
        data: {RequestDataNames.targetUserId: targetUserId},
      );
      await firebaseHelper.addDocument(
        collectionPath: '$targetUserDocPath/${CollectionNames.followers}',
        docId: currentUserId,
        data: {RequestDataNames.targetUserId: currentUserId},
      );

      await firebaseHelper.updateDocument(
        collectionPath: currentUserDocPath,
        docId: currentUserId,
        data: {RequestDataNames.followingCount: FieldValue.increment(1)},
      );
      await firebaseHelper.updateDocument(
        collectionPath: targetUserDocPath,
        docId: targetUserId,
        data: {RequestDataNames.followersCount: FieldValue.increment(1)},
      );
    }

    final targetUserData = await firebaseHelper.getDocument(
      collectionPath: CollectionNames.users,
      docId: targetUserId,
    );

    return UserModel.fromJson(targetUserData!);
  }

  @override
  Future<int> getFollowersCount({
    required String userId,
  }) async {
    final followersSnapshot = await firebaseHelper.getCollectionQuerySnapshot(
      collectionPath: '${CollectionNames.users}/$userId/${CollectionNames.followers}',
    );
    return followersSnapshot.size;
  }

  @override
  Future<int> getFollowingCount({
    required String userId,
  }) async {
    final followingSnapshot = await firebaseHelper.getCollectionQuerySnapshot(
      collectionPath: '${CollectionNames.users}/$userId/${CollectionNames.following}',
    );
    return followingSnapshot.size;
  }

  @override
  Future<bool> isUserFollowed({
    required String currentUserId,
    required String targetUserId,
  }) async {
    final docSnapshot = await firebaseHelper.getDocument(
      collectionPath: '${CollectionNames.users}/$currentUserId/${CollectionNames.following}',
      docId: targetUserId,
    );

    return docSnapshot != null;
  }
}
