import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts/Features/favourites_feature/data/favourites_model/favourites_model.dart';

import '../../../../../core/network/firebase_manager/collection_names.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../../authentication_feature/data/user_model/user_model.dart';

abstract class FavouritesRemoteDataSource {
  Future<List<FavouritesVideoModel>> getFavouriteVideos({
    required UserEntity user,
  });
  Future<bool> toggleFavouriteVideo({
    required String videoId,
    required UserEntity user,
    required UserModel userModel,
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
    required String videoId,
    required UserEntity user,
    required UserModel userModel,
  }) async {
    final userFavouritess = firestore
        .collection(CollectionNames.users)
        .doc(userModel.id)
        .collection(CollectionNames.favourites)
        .doc(videoId);

    final userFavourites = await userFavouritess.get();

    if (userFavourites.exists) {
      await userFavouritess.delete();
      return false;
    } else {
      final globalVideoRef =
          firestore.collection(CollectionNames.videos).doc(videoId);
      final globalVideoDoc = await globalVideoRef.get();

      if (globalVideoDoc.exists) {
        final videoData = globalVideoDoc.data() as Map<String, dynamic>;

        await userFavouritess.set(videoData);

        print('Video added to favourites collection');
        return true;
      } else {
        return false;
      }
    }
  }
}
