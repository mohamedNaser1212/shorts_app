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
      subCollectionPath: CollectionNames.favourites,
    );

    return querySnapshot
        .map((data) => FavouritesVideoModel.fromJson(data))
        .toList();
  }

  @override
  Future<bool> toggleFavouriteVideo({
    required VideoEntity videoEntity,
    required UserEntity userModel,
  }) async {
    final userFavoritesPath =
        '${CollectionNames.users}/${userModel.id}/${CollectionNames.favourites}';
    final favouriteVideoDoc = await firebaseHelperManager.getDocument(
      collectionPath: userFavoritesPath,
      docId: videoEntity.id,
    );

    if (favouriteVideoDoc != null) {
      await firebaseHelperManager.deleteDocument(
        collectionPath: CollectionNames.users,
        docId: userModel.id!,
        subCollectionPath: CollectionNames.favourites,
        subDocId: videoEntity.id,
      );

      await firebaseHelperManager.deleteDocument(
        collectionPath:
            '${CollectionNames.videos}/${videoEntity.id}/${CollectionNames.favourites}',
        docId: userModel.id!,
      );

      return false;
    } else {
      final globalVideoDoc = await firebaseHelperManager.getDocument(
        collectionPath: CollectionNames.videos,
        docId: videoEntity.id,
      );

      if (globalVideoDoc != null) {
        await firebaseHelperManager.addDocument(
          collectionPath: userFavoritesPath,
          data: globalVideoDoc,
          docId: videoEntity.id,
        );

        await firebaseHelperManager.addDocument(
          collectionPath:
              '${CollectionNames.videos}/${videoEntity.id}/${CollectionNames.favourites}',
          data: {
            'userId': userModel.id,
            'timeStamp': DateTime.now(),
          },
          docId: userModel.id!,
        );

        return true;
      } else {
        print('Error: Video not found in global videos collection.');
        return false;
      }
    }
  }

  @override
  Future<num> getFavouritesCount({
    required String videoId,
  }) async {
    final querySnapshot = await firebaseHelperManager.getCollectionDocuments(
      collectionPath:
          '${CollectionNames.videos}/$videoId/${CollectionNames.favourites}',
    );
    return querySnapshot.length;
  }
}
