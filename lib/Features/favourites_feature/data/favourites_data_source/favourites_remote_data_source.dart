import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts/Features/favourites_feature/data/favourites_model/favourites_model.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';

import '../../../../../core/network/firebase_manager/collection_names.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';

abstract class FavouritesRemoteDataSource {
  const FavouritesRemoteDataSource._();
  Future<List<FavouritesVideoModel>> getFavouriteVideos({
    required UserEntity user,
  });
  Future<bool> toggleFavouriteVideo({
    required VideoEntity videoEntity,
    required UserEntity userModel,
  });
  Future<num> getFavouritesCount({required String videoId});
}

class FavouritesRemoteDataSourceImpl implements FavouritesRemoteDataSource {
  final FirebaseHelper firebaseHelperManager;

  FavouritesRemoteDataSourceImpl({required this.firebaseHelperManager});

  @override
  Future<List<FavouritesVideoModel>> getFavouriteVideos({
    required UserEntity user,
  }) async {
    final querySnapshot = await firebaseHelperManager.getCollectionDocuments(
      collectionPath: CollectionNames.users,
      docId: user.id,
      subCollectionPath: CollectionNames.likes,
    );

    List<FavouritesVideoModel> favouriteVideos = [];

    for (var data in querySnapshot) {
      final videoId = data['videoId'];

      final videoSnapshot = await firebaseHelperManager.getDocument(
        collectionPath: CollectionNames.videos,
        docId: videoId,
      );

      if (videoSnapshot != null) {
        favouriteVideos.add(FavouritesVideoModel.fromJson(videoSnapshot));
      }
    }

    return favouriteVideos;
  }

  @override
  Future<bool> toggleFavouriteVideo({
    required VideoEntity videoEntity,
    required UserEntity userModel,
  }) async {
    final userLikesPath =
        '${CollectionNames.users}/${userModel.id}/${CollectionNames.likes}';
    final videoLikesPath =
        '${CollectionNames.videos}/${videoEntity.id}/${CollectionNames.likes}';

    final currentUserLikeDoc = await firebaseHelperManager.getDocument(
      collectionPath: userLikesPath,
      docId: videoEntity.id!,
    );

    if (currentUserLikeDoc != null) {
      await firebaseHelperManager.deleteDocument(
        collectionPath: userLikesPath,
        docId: videoEntity.id!,
      );

      await firebaseHelperManager.deleteDocument(
        collectionPath: videoLikesPath,
        docId: userModel.id!,
      );

      await firebaseHelperManager.updateDocument(
        collectionPath: CollectionNames.videos,
        docId: videoEntity.id,
        data: {
          'user.likesCount': FieldValue.increment(-1),
        },
      );

      await firebaseHelperManager.updateDocument(
        collectionPath: CollectionNames.users,
        docId: videoEntity.user.id!,
        data: {
          'likesCount': FieldValue.increment(-1),
        },
      );

      return false;
    } else {
      await firebaseHelperManager.addDocument(
        collectionPath: userLikesPath,
        docId: videoEntity.id!,
        data: {
          'videoId': videoEntity.id,
          'timeStamp': DateTime.now(),
        },
      );

      await firebaseHelperManager.addDocument(
        collectionPath: videoLikesPath,
        docId: userModel.id!,
        data: {
          'userId': userModel.id,
          'timeStamp': DateTime.now(),
        },
      );

      await firebaseHelperManager.updateDocument(
        collectionPath: CollectionNames.videos,
        docId: videoEntity.id,
        data: {
          'user.likesCount': FieldValue.increment(1),
        },
      );

      await firebaseHelperManager.updateDocument(
        collectionPath: CollectionNames.users,
        docId: videoEntity.user.id!,
        data: {
          'likesCount': FieldValue.increment(1),
        },
      );

      return true;
    }
  }

  @override
  Future<num> getFavouritesCount({
    required String videoId,
  }) async {
    final querySnapshot = await firebaseHelperManager.getCollectionDocuments(
      collectionPath:
          '${CollectionNames.videos}/$videoId/${CollectionNames.likes}',
    );
    return querySnapshot.length;
  }
}
