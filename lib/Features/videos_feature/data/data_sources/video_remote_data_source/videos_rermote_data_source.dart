import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart'; // Import FirebaseHelper
import 'package:uuid/uuid.dart';

abstract class VideosRemoteDataSource {
  Future<List<VideoModel>> getVideos();
  Future<VideoModel> uploadVideo({
    required String description,
    required String videoPath,
  });
}

class VideosRemoteDataSourceImpl implements VideosRemoteDataSource {
  final FirebaseHelper firebaseHelper;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid _uuid = const Uuid();

  VideosRemoteDataSourceImpl({
    required this.firebaseHelper,
  });

  @override
  Future<List<VideoModel>> getVideos() async {
    final data = await firebaseHelper.get(collectionPath: 'videos');
    return data.map((doc) => VideoModel.fromJson(doc)).toList();
  }

  @override
  Future<VideoModel> uploadVideo({
    required String description,
    required String videoPath,
  }) async {
    final videoId = _uuid.v4();
    final videoUrl = await _uploadVideoToStorage(videoPath, videoId);

    final video = VideoModel(
      id: videoId,
      description: description,
      videoUrl: videoUrl,
      thumbnail: '',
    );

    await firebaseHelper.post(
      collectionPath: 'videos',
      data: video.toJson(),
      documentId: videoId,
    );

    return video;
  }

  Future<String> _uploadVideoToStorage(String videoPath, String videoId) async {
    final videoRef = _storage.ref().child('videos').child(videoId);
    final uploadTask = videoRef.putFile(File(videoPath));
    final snapshot = await uploadTask.whenComplete(() => null);
    final videoUrl = await snapshot.ref.getDownloadURL();
    return videoUrl;
  }
}
