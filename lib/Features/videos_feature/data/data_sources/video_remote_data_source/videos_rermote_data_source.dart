import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/core/utils/constants/request_data_names.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/network/firebase_manager/collection_names.dart';
import '../../../../../core/user_info/domain/user_entity/user_entity.dart';

abstract class VideosRemoteDataSource {
  const VideosRemoteDataSource._();
  Future<List<VideoModel>> getVideos();
  Future<VideoModel> uploadVideo({
    required String description,
    required String videoPath,
    required UserEntity user,
    required String thumbnailPath,
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
    required String thumbnailPath,
  }) async {
    final videoId = _uuid.v4();
    
    final videoUrl = await _uploadVideoToStorage(videoId: videoId, videoPath: videoPath);
    final thumbnailUrl = await _uploadThumbnailToStorage(videoId: videoId, thumbnailPath: thumbnailPath);
    
    VideoModel video = VideoModel(
      id: videoId,
      description: description,
      videoUrl: videoUrl,
      thumbnail: thumbnailUrl, 
      user: user,
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

  Future<String> _uploadThumbnailToStorage({
    required String videoId,
    required String thumbnailPath,
  }) async {
    final Reference storageRef =
        firebaseStorage.ref().child('thumbnails/$videoId.jpg'); 
      
    final UploadTask uploadTask = storageRef.putFile(File(thumbnailPath));
    final TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  @override
  Future<List<VideoModel>> getFavouriteVideos() async {
    final querySnapshot = await firestore
        .collection(CollectionNames.videos)
        .where(RequestDataNames.isFavourite, isEqualTo: true)
        .get();

    return querySnapshot.docs
        .map((doc) => VideoModel.fromJson(doc.data()))
        .toList();
  }
}
