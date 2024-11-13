import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts/Features/authentication_feature/data/user_model/user_model.dart';

import '../../../videos_feature/data/model/video_model.dart';

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

class UserProfileVideosRemoteDataSourceImpl
    extends UserProfilesRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot? _lastDocument;
  static const int _defaultPageSize = 6;
  Map<num, DocumentSnapshot?> lastVideos = {};
  bool hasMoreVideos = true;
  final int limit = _defaultPageSize;

  @override
  Future<List<VideoModel>> getUserVideos({
    required String userId,
    int pageSize = 9,
  }) async {
    if (!hasMoreVideos) return [];
    Query query = firestore
        .collection('users/$userId/videos')
        .orderBy('timeStamp', descending: true)
        .limit(limit);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    final querySnapshot = await query.get();
    if (querySnapshot.docs.isEmpty) {
      hasMoreVideos = false;
      return [];
    }
    List<VideoModel> videos = querySnapshot.docs
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
    final currentUserDoc = firestore.collection('users').doc(currentUserId);
    final targetUserDoc = firestore.collection('users').doc(targetUserId);

    final docSnapshot =
        await currentUserDoc.collection('following').doc(targetUserId).get();
    bool isFollowing = docSnapshot.exists;

    if (isFollowing) {
      await currentUserDoc.collection('following').doc(targetUserId).delete();
      await targetUserDoc.collection('followers').doc(currentUserId).delete();

      // Decrease the following and followers count
      await currentUserDoc.update({
        'followingCount': FieldValue.increment(-1),
      });
      await targetUserDoc.update({
        'followersCount': FieldValue.increment(-1),
      });
    } else {
      // Follow: Add to both following and followers collections
      await currentUserDoc.collection('following').doc(targetUserId).set({
        'targetUserId': targetUserId,
      });
      await targetUserDoc.collection('followers').doc(currentUserId).set({
        'targetUserId': currentUserId,
      });

      // Increase the following and followers count
      await currentUserDoc.update({
        'followingCount': FieldValue.increment(1),
      });
      await targetUserDoc.update({
        'followersCount': FieldValue.increment(1),
      });
    }

    // Fetch updated user data
    final targetUserSnapshot = await targetUserDoc.get();
    final targetUser = UserModel.fromJson(targetUserSnapshot.data()!);

    return targetUser;
  }

  @override
  Future<int> getFollowersCount({
    required String userId,
  }) async {
    final followersSnapshot =
        await firestore.collection('users/$userId/followers').get();
    return followersSnapshot.size;
  }

  @override
  Future<int> getFollowingCount({
    required String userId,
  }) async {
    final followingSnapshot =
        await firestore.collection('users/$userId/following').get();
    return followingSnapshot.size;
  }

  @override
  Future<bool> isUserFollowed({
    required String currentUserId,
    required String targetUserId,
  }) async {
    final docSnapshot = await firestore
        .collection('users')
        .doc(currentUserId)
        .collection('following')
        .doc(targetUserId)
        .get();

    return docSnapshot.exists;
  }
}
