import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:uuid/uuid.dart'; // Import uuid package

abstract class VideosRemoteDataSource {
  Future<List<VideoModel>> getVideos();
  Future<VideoModel> uploadVideo({
    required String description,
    required String videoPath,
  });
}

class VideosRemoteDataSourceImpl implements VideosRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid _uuid = const Uuid();

  @override
  Future<List<VideoModel>> getVideos() async {
    try {
      final snapshot = await _firestore.collection('videos').get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return VideoModel.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception('Error fetching videos: $e');
    }
  }

  @override
  Future<VideoModel> uploadVideo({
    required String description,
    required String videoPath,
  }) async {
    final videoId = _uuid.v4();
    final videoRef = _storage.ref().child('videos').child(videoId);
    final uploadTask = videoRef.putFile(File(videoPath));
    final snapshot = await uploadTask.whenComplete(() => null);
    final videoUrl = await snapshot.ref.getDownloadURL();
    final video = VideoModel(
      videoUrl: videoUrl,
      thumbnail: '',
      description: description,
      id: videoId,
    );
    await _firestore.collection('videos').doc(videoId).set(video.toJson());
    return video;
  }
}
