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
  DocumentSnapshot? _lastDocument;
  static const int _defaultPageSize = 2;
  Map<num, DocumentSnapshot?> lastVideos = {};
  bool hasMoreVideos = true;
  final int limit = _defaultPageSize;
  VideosRemoteDataSourceImpl({required this.firebaseHelperManager});
  @override
  Future<List<VideoModel>> getVideos() async {
    if (!hasMoreVideos) return [];

    Query query = FirebaseFirestore.instance
        .collection(CollectionNames.videos)
        .orderBy('timeStamp', descending: true)
        .limit(limit);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    final querySnapshot = await query.get();

    if (querySnapshot.docs.isEmpty) {
      hasMoreVideos = false;
      return [];
    }

    final videos = querySnapshot.docs.map((doc) {
      return VideoModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    _lastDocument = querySnapshot.docs.last;

    if (videos.length < limit) {
      hasMoreVideos = false;
    }
    print('videos.length${videos.length}');

    return videos;
  }

  void resetPagination() {
    _lastDocument = null;
  }

  @override
  Future<VideoModel> uploadVideo({
    required VideoModel videoModel,
    UserEntity? sharedBy,
  }) async {
    final videoUrl = await _uploadVideoToStorage(
      videoId: videoModel.id,
      videoPath: videoModel.videoUrl,
    );
    final thumbnailUrl = await _uploadThumbnailToStorage(
      videoId: videoModel.id,
      thumbnailPath: videoModel.thumbnail,
    );

    final updatedVideoModel = VideoModel(
      id: videoModel.id,
      thumbnail: thumbnailUrl,
      videoUrl: videoUrl,
      user: videoModel.user,
      description: videoModel.description,
      timeStamp: DateTime.now(),
    );

    await _uploadVideoToVideosCollection(
      videoModel: updatedVideoModel,
    );
    await _uploadVideoToUserCollection(
      videoModel: updatedVideoModel,
    );

    return updatedVideoModel;
  }

  Future<void> _uploadVideoToVideosCollection({
    required VideoModel videoModel,
  }) async {
    await firebaseHelperManager.addDocument(
      collectionPath: CollectionNames.videos,
      data: videoModel.toJson(),
      docId: videoModel.id,
    );
  }

  Future<void> _uploadVideoToUserCollection({
    required VideoModel videoModel,
  }) async {
    await firebaseHelperManager.addDocument(
      collectionPath: CollectionNames.users,
      docId: videoModel.user.id,
      subCollectionPath: CollectionNames.videos,
      subDocId: videoModel.id,
      data: videoModel.toJson(),
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
    final newVideoId = await firebaseHelperManager.generateDocumentId(
      collectionPath: CollectionNames.videos,
    );

    final sharedVideoModel = VideoModel(
      id: newVideoId,
      thumbnail: model.thumbnail,
      videoUrl: model.videoUrl,
      user: model.user,
      description: model.description,
      timeStamp: DateTime.now(),
    );

    await firebaseHelperManager.addDocument(
      collectionPath: CollectionNames.videos,
      data: sharedVideoModel.toJson(),
      docId: newVideoId,
    );

    await _uploadSharedVideoToCollection(
      sharedVideoModel,
      user,
      text,
    );
    await _addSharedVideoToUserCollection(sharedVideoModel, user, text);
  }

  Future<void> _uploadSharedVideoToCollection(
    VideoModel sharedVideoModel,
    UserEntity user,
    String shareText,
  ) async {
    final shareVideoModel = ShareVideoModel(
      videoModel: sharedVideoModel,
      shareUserName: user.name,
      shareUserImage: user.profilePic,
      shareUserId: user.id,
      shareVideoText: shareText,
    );
    await firebaseHelperManager.addDocument(
      collectionPath: CollectionNames.videos,
      data: shareVideoModel.toMap(),
      docId: sharedVideoModel.id,
    );
  }

  Future<void> _addSharedVideoToUserCollection(
    VideoModel sharedVideoModel,
    UserEntity user,
    String shareText,
  ) async {
    final shareVideoModel = ShareVideoModel(
      videoModel: sharedVideoModel,
      shareUserName: user.name,
      shareUserImage: user.profilePic,
      shareUserId: user.id,
      shareVideoText: shareText,
    );

    await firebaseHelperManager.addDocument(
      collectionPath: CollectionNames.users,
      docId: user.id,
      subCollectionPath: CollectionNames.videos,
      subDocId: sharedVideoModel.id,
      data: shareVideoModel.toMap(),
    );
  }
}
