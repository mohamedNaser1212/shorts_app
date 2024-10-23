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

  Future<List<VideoModel>> getVideos(
      {required int pageSize, required int page});

  Future<VideoModel> uploadVideo({
    required VideoModel videoModel,
    UserEntity? sharedBy,
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

  static const int _defaultPageSize = 1;
  DocumentSnapshot? _lastDocument;

  VideosRemoteDataSourceImpl({required this.firebaseHelperManager});

  @override
  Future<List<VideoModel>> getVideos(
      {int pageSize = _defaultPageSize, required int page}) async {
    List<Map<String, dynamic>> documentsData;

    if (page == 1) {
      documentsData = await firebaseHelperManager.getCollectionDocuments(
        collectionPath: CollectionNames.videos,
        limit: pageSize,
      );
      print('Documents Data: $documentsData');
    } else {
      documentsData = await firebaseHelperManager.getCollectionDocuments(
        collectionPath: CollectionNames.videos,
        limit: pageSize,
      );
      print('Documents Data: $documentsData');
    }

    if (documentsData.isNotEmpty) {
      _lastDocument = await FirebaseFirestore.instance
          .collection(CollectionNames.videos)
          .doc(documentsData.last['id'])
          .get();
    }

    print(documentsData.map((doc) => VideoModel.fromJson(doc)).toList().length);

    return documentsData.map((doc) => VideoModel.fromJson(doc)).toList();
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
        videoId: videoModel.id, videoPath: videoModel.videoUrl);
    final thumbnailUrl = await _uploadThumbnailToStorage(
        videoId: videoModel.id, thumbnailPath: videoModel.thumbnail);

    final updatedVideoModel = videoModel.copyWith(
      videoUrl: videoUrl,
      thumbnail: thumbnailUrl,
      sharedBy: sharedBy ?? videoModel.sharedBy,
    );

    await _uploadVideoToVideosCollection(videoModel, updatedVideoModel);
    await _uploadVideoToUserCollection(videoModel);

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

  Future<void> _uploadVideoToUserCollection(VideoModel videoModel) async {
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
    await firebaseHelperManager.addDocument(
      collectionPath: CollectionNames.videos,
      data: model.toJson(),
      docId: newVideoId,
    );

    final sharedVideoModel = model.copyWith(
      id: newVideoId,
      sharedBy: user,
    );

    await _uploadSharedVideoToCollection(sharedVideoModel);
    await _addSharedVideoToUserCollection(sharedVideoModel, user, text);
  }

  Future<void> _uploadSharedVideoToCollection(
      VideoModel sharedVideoModel) async {
    await firebaseHelperManager.addDocument(
      collectionPath: CollectionNames.videos,
      data: sharedVideoModel.toJson(),
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
