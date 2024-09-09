import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart'; // Import uuid package
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';

abstract class VideosRemoteDataSource {
  Future<List<VideoModel>> getVideos();
  Future<VideoModel> uploadVideo();
}

class VideosRemoteDataSourceImpl implements VideosRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid _uuid = Uuid(); // Instantiate Uuid

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
  Future<VideoModel> uploadVideo() async {
    try {
      // Use FilePicker to select a video
      final result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );

      if (result == null || result.files.isEmpty) {
        throw Exception('No video selected');
      }

      final filePath = result.files.single.path;
      if (filePath == null) {
        throw Exception('Invalid file path');
      }

      final videoId = _uuid.v4();

      // Upload video to Firebase Storage
      final videoRef = _storage.ref().child('videos/$videoId.mp4');
      final uploadTask = videoRef.putFile(File(filePath));
      final snapshot = await uploadTask.whenComplete(() => null);

      final videoUrl = await snapshot.ref.getDownloadURL();

      final videoData = VideoModel(
        id: videoId,
        title: result.files.single.name,
        thumbnail: '',
        videoUrl: videoUrl,
      );

      await _firestore
          .collection('videos')
          .doc(videoId)
          .set(videoData.toJson());

      return videoData;
    } catch (e) {
      throw Exception('Error uploading video: $e');
    }
  }
}
