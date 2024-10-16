import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts/Features/favourites_feature/data/favourites_model/favourites_model.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import '../../../../../core/network/firebase_manager/collection_names.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';

abstract class FavouritesRemoteDataSource {
  const FavouritesRemoteDataSource._();
  Future<List<FavouritesVideoModel>> getFavouriteVideos({
    required UserEntity user,
  });
  Future<bool> toggleFavouriteVideo({
    required  VideoEntity videoEntity,
    required UserEntity userModel,
  });
}

class FavouritesRemoteDataSourceImpl implements FavouritesRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;



  @override
  Future<List<FavouritesVideoModel>> getFavouriteVideos({
    required UserEntity user,
  }) async {
    final querySnapshot = await firestore
        .collection(CollectionNames.users)
        .doc(user.id)
        .collection(CollectionNames.favourites)
        .get();

    return querySnapshot.docs
        .map((doc) => FavouritesVideoModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<bool> toggleFavouriteVideo({
    required  VideoEntity videoEntity,
    required UserEntity userModel,
  }) async {
    final userFavouritesCollection = firestore
        .collection(CollectionNames.users)
        .doc(userModel.id)
        .collection(CollectionNames.favourites)
        .doc(videoEntity.id);

    final favourites = await userFavouritesCollection.get();

    if (favourites.exists) {
      await userFavouritesCollection.delete();
      return false;
    } else {
      final globalVideoRef =
          firestore.collection(CollectionNames.videos).doc(videoEntity.id);
      final globalVideoDoc = await globalVideoRef.get();

      if (globalVideoDoc.exists) {
        final videoData = globalVideoDoc.data() as Map<String, dynamic>;

        await userFavouritesCollection.set(videoData);

        print('Video added to favourites collection');
        return true;
      } else {
        return false;
      }
    }
  }
}
