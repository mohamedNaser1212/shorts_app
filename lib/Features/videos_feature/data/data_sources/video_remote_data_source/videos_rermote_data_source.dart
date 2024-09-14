import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shorts/Features/authentication_feature/data/user_model/user_model.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/network/firebase_manager/collection_names.dart';

abstract class VideosRemoteDataSource {
  Future<List<VideoModel>> getVideos();
  Future<VideoModel> uploadVideo({
    required String description,
    required String videoPath,
    required UserModel user,
  });
}

class VideosRemoteDataSourceImpl implements VideosRemoteDataSource {
  final FirebaseHelper firebaseHelper;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final Uuid _uuid = const Uuid();

  VideosRemoteDataSourceImpl({
    required this.firebaseHelper,
  });

  @override
  Future<List<VideoModel>> getVideos() async {
    final data = await firebaseHelper.get(
      collectionPath: CollectionNames.videos,
    );
    return data.map((video) => VideoModel.fromJson(video)).toList();
  }

  @override
  Future<VideoModel> uploadVideo({
    required String description,
    required String videoPath,
    required UserModel user,
  }) async {
    final videoId = _uuid.v4();

    final videoUrl = await _uploadVideoToStorage(
      videoId: videoId,
      videoPath: videoPath,
    );

    // Create video model
    final video = VideoModel(
      id: videoId,
      description: description,
      videoUrl: videoUrl,
      thumbnail:
          '', // You may add a logic for generating or uploading a thumbnail
      user: user, // Already the passed user; no need to update
    );

    // Save the video data to the main videos collection
    await firestore
        .collection(CollectionNames.videos)
        .doc(videoId)
        .set(video.toJson());

    // Save the video data to the user's videos collection
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

    // Wait for the upload to complete
    final TaskSnapshot snapshot = await uploadTask;

    // Get the video URL
    return await snapshot.ref.getDownloadURL();
  }
}
