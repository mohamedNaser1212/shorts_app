import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/network/firebase_manager/collection_names.dart';
import '../../../videos_feature/data/model/video_model.dart';

abstract class FavouritesRemoteDataSource {
  Future<List<VideoModel>> getFavouriteVideos();
  Future<bool> toggleFavouriteVideo({
    required String videoId,
  });
}

class FavouritesRemoteDataSourceImpl implements FavouritesRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<VideoModel>> getFavouriteVideos() async {
    try {
      final querySnapshot = await firestore
          .collection(CollectionNames.videos)
          .where('isFavourite', isEqualTo: true)
          .get();

      return querySnapshot.docs
          .map((doc) => VideoModel.fromJson(doc.data()))
          .toList();
    } catch (error) {
      print('Failed to fetch favourite videos: $error');
      return [];
    }
  }

  @override
  Future<bool> toggleFavouriteVideo({
    required String videoId,
  }) async {
    final videoRef = firestore.collection(CollectionNames.videos).doc(videoId);

    final videoDoc = await videoRef.get();
    if (videoDoc.exists) {
      final videoData = videoDoc.data() as Map<String, dynamic>;
      final bool isCurrentlyFavourite = videoData['isFavourite'] ?? false;

      await videoRef.update({
        'isFavourite': !isCurrentlyFavourite,
      });

      print(isCurrentlyFavourite
          ? 'Video removed from favourites'
          : 'Video added to favourites');

      return !isCurrentlyFavourite;
    } else {
      print('Video not found');
      return false;
    }
  }
}
