import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shorts/Features/favourites_feature/data/favourites_model/favourites_model.dart';

import '../../../../../core/network/firebase_manager/collection_names.dart';
import '../../../../core/constants/consts.dart';

abstract class FavouritesRemoteDataSource {
  Future<List<FavouritesVideoModel>> getFavouriteVideos();
  Future<bool> toggleFavouriteVideo({
    required String videoId,
  });
}

class FavouritesRemoteDataSourceImpl implements FavouritesRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<FavouritesVideoModel>> getFavouriteVideos() async {
    final querySnapshot = await firestore
        .collection(CollectionNames.users)
        .doc(uId)
        .collection(CollectionNames.favourites)
        .get();

    return querySnapshot.docs
        .map((doc) => FavouritesVideoModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<bool> toggleFavouriteVideo({
    required String videoId,
  }) async {
    final userFavouritesRef = firestore
        .collection(CollectionNames.users)
        .doc(uId)
        .collection(CollectionNames.favourites)
        .doc(videoId);

    final userFavouriteDoc = await userFavouritesRef.get();

    if (userFavouriteDoc.exists) {
      await userFavouritesRef.delete();
      print('Video removed from favourites collection');
      return false;
    } else {
      final globalVideoRef =
          firestore.collection(CollectionNames.videos).doc(videoId);
      final globalVideoDoc = await globalVideoRef.get();

      if (globalVideoDoc.exists) {
        final videoData = globalVideoDoc.data() as Map<String, dynamic>;

        // Add the video to the user's Favourites sub-collection
        await userFavouritesRef.set(videoData);

        print('Video added to favourites collection');
        return true;
      } else {
        print('Video not found in global videos collection');
        return false;
      }
    }
  }
}
