import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/network/firebase_manager/collection_names.dart';
import '../../../../../core/user_info/domain/user_entity/user_entity.dart';

abstract class VideosRemoteDataSource {
  Future<List<VideoModel>> getVideos();
  Future<VideoModel> uploadVideo({
    required String description,
    required String videoPath,
    required UserEntity user,
  });
  Future<List<VideoModel>> getFavouriteVideos();
}

class VideosRemoteDataSourceImpl implements VideosRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final Uuid _uuid = const Uuid();

  @override
  Future<List<VideoModel>> getVideos() async {
    final data = await firestore.collection(CollectionNames.videos).get();
    return data.docs.map((doc) => VideoModel.fromJson(doc.data())).toList();
  }

  @override
  Future<VideoModel> uploadVideo({
    required String description,
    required String videoPath,
    required UserEntity user,
  }) async {
    final videoId = _uuid.v4();
    final videoUrl =
        await _uploadVideoToStorage(videoId: videoId, videoPath: videoPath);
    final video = VideoModel(
      id: videoId,
      description: description,
      videoUrl: videoUrl,
      thumbnail: '',
      user: user,
      comments: [],
    );

    await firestore
        .collection(CollectionNames.videos)
        .doc(videoId)
        .set(video.toJson());
    await firestore
        .collection(CollectionNames.users)
        .doc(user.id)
        .collection(CollectionNames.videos)
        .doc(videoId)
        .set(video.toJson());

    return video;
  }

  Future<String> _uploadVideoToStorage({
    required String videoId,
    required String videoPath,
  }) async {
    final Reference storageRef =
        firebaseStorage.ref().child('videos/$videoId.mp4');
    final UploadTask uploadTask = storageRef.putFile(File(videoPath));
    final TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  @override
  Future<List<VideoModel>> getFavouriteVideos() async {
    final querySnapshot = await firestore
        .collection(CollectionNames.videos)
        .where('isFavourite', isEqualTo: true)
        .get();

    return querySnapshot.docs
        .map((doc) => VideoModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<bool> toggleFavouriteVideo({
    required String videoId,
    required UserEntity user,
  }) async {
    final videoRef = firestore.collection(CollectionNames.videos).doc(videoId);
    final userFavouritesRef = firestore
        .collection(CollectionNames.users)
        .doc(user.id)
        .collection(CollectionNames.favourites)
        .doc(videoId);

    final videoDoc = await videoRef.get();

    if (videoDoc.exists) {
      final videoData = videoDoc.data() as Map<String, dynamic>;
      final bool isCurrentlyFavourite = videoData['isFavourite'] ?? false;

      // Update video favourite status
      await videoRef.update({'isFavourite': !isCurrentlyFavourite});

      // Update user's favourites list
      if (!isCurrentlyFavourite) {
        await userFavouritesRef.set({
          'videoId': videoId,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } else {
        await userFavouritesRef.delete();
      }

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
