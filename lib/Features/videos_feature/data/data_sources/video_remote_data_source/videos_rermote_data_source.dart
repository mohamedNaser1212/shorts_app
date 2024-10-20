import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shorts/Features/videos_feature/data/model/shared_videos_model.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';
import '../../../../../core/network/firebase_manager/collection_names.dart';

abstract class VideosRemoteDataSource {
  const VideosRemoteDataSource._();
  Future<List<VideoModel>> getVideos();
  Future<VideoModel> uploadVideo({
    required VideoModel videoModel,
    UserEntity? sharedBy, // Optional sharedBy user parameter
  });

  Future<void> shareVideo({
    required VideoModel model,
    required String text,
    required UserEntity user,
  });
}

class VideosRemoteDataSourceImpl implements VideosRemoteDataSource {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseHelper firebaseHelperManager;

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
    UserEntity? sharedBy, // Optional sharedBy user parameter
  }) async {
    // Upload video and thumbnail to Firebase Storage
    final videoUrl = await _uploadVideoToStorage(
        videoId: videoModel.id, videoPath: videoModel.videoUrl);
    final thumbnailUrl = await _uploadThumbnailToStorage(
        videoId: videoModel.id, thumbnailPath: videoModel.thumbnail);

    // Update videoModel with sharedBy if the video is shared
    final updatedVideoModel = videoModel.copyWith(
      videoUrl: videoUrl,
      thumbnail: thumbnailUrl,
      sharedBy: sharedBy ?? videoModel.sharedBy, // Set sharedBy if provided
    );

    // Upload video to relevant collections
    await _uploadVideoToVideosCollection(videoModel, updatedVideoModel);
    await _uploadVideoToUserCollection(videoModel, updatedVideoModel);

    return updatedVideoModel;
  }

  Future<void> _uploadVideoToVideosCollection(
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
  Future<void> shareVideo({
    required VideoModel model,
    required String text,
    required UserEntity user,
  }) async {
    ShareVideoModel shareVideoModel = ShareVideoModel(
      videoModel: model,
      shareUserName: user.name,
      shareUserImage: user.profilePic,
      shareUserId: user.id,
      shareVideoText: text,
    );

    shareVideoModel.videoId = model.id;

    await FirebaseFirestore.instance.collection(CollectionNames.videos).add({
      ...shareVideoModel.toMap(),
    });
  }
}
