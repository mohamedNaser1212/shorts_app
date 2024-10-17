import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/firebase_helper.dart';
import '../../../../../core/network/firebase_manager/collection_names.dart';

abstract class VideosRemoteDataSource {
  const VideosRemoteDataSource._();
  Future<List<VideoModel>> getVideos();
  Future<VideoModel> uploadVideo({
    required VideoModel videoModel,
  });
}

class VideosRemoteDataSourceImpl implements VideosRemoteDataSource {
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  final FirebaseHelperManager firebaseHelperManager;

  VideosRemoteDataSourceImpl({required this.firebaseHelperManager});
  @override
  Future<List<VideoModel>> getVideos() async {
    final data = await firebaseHelperManager.getCollectionDocuments(
      collectionPath: CollectionNames.videos,
    );
    return data.map((video) => VideoModel.fromJson(video)).toList();
  }

  @override
  Future<VideoModel> uploadVideo({
    required VideoModel videoModel,
  }) async {
    final videoUrl = await _uploadVideoToStorage(
        videoId: videoModel.id, videoPath: videoModel.videoUrl);
    final thumbnailUrl = await _uploadThumbnailToStorage(
        videoId: videoModel.id, thumbnailPath: videoModel.thumbnail);

    final updatedVideoModel = videoModel.copyWith(
      videoUrl: videoUrl,
      thumbnail: thumbnailUrl,
    );

    await _uploadVideoToVideosCollection(videoModel, updatedVideoModel);
    await _uploadVideoToUserCollection(videoModel, updatedVideoModel);

    return updatedVideoModel;
  }

  _uploadVideoToVideosCollection(
      VideoModel videoModel, VideoModel updatedVideoModel) async {
    await firebaseHelperManager.addDocument(
      collectionPath: CollectionNames.videos,
      data: updatedVideoModel.toJson(),
      docId: videoModel.id,
    );
  }

  Future<void> _uploadVideoToUserCollection(
      VideoModel videoModel, VideoModel updatedVideoModel) async {
    await firebaseHelperManager.addDocument(
      collectionPath: CollectionNames.users,
      docId: videoModel.user.id,
      subCollectionPath: CollectionNames.videos,
      subDocId: videoModel.id,
      data: updatedVideoModel.toJson(),
    );

    // await firestore
    //     .collection(CollectionNames.users)
    //     .doc(videoModel.user.id)
    //     .collection(CollectionNames.videos)
    //     .doc(videoModel.id)
    //     .set(updatedVideoModel.toJson());
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
}
