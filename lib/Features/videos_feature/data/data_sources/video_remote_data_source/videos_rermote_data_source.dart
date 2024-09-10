import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/core/network/firebase_manager/firebase_helper.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/network/firebase_manager/collection_names.dart';

abstract class VideosRemoteDataSource {
  Future<List<VideoModel>> getVideos();
  Future<VideoModel> uploadVideo({
    required String description,
    required String videoPath,
  });
}

class VideosRemoteDataSourceImpl implements VideosRemoteDataSource {
  final FirebaseHelper firebaseHelper;
  final Uuid _uuid = const Uuid();

  VideosRemoteDataSourceImpl({
    required this.firebaseHelper,
  });

  @override
  Future<List<VideoModel>> getVideos() async {
    final data = await firebaseHelper.get(
      collectionPath: CollectionNames.videos,
    );
    return data.map((doc) => VideoModel.fromJson(doc)).toList();
  }

  @override
  Future<VideoModel> uploadVideo({
    required String description,
    required String videoPath,
  }) async {
    final videoId = _uuid.v4();
    final videoUrl = await firebaseHelper.uploadToStorage(
      videoPath: videoPath,
      videoId: videoId,
      collectionName: CollectionNames.videos,
    );

    final video = VideoModel(
      id: videoId,
      description: description,
      videoUrl: videoUrl,
      thumbnail: '',
    );

    await firebaseHelper.post(
      collectionPath: CollectionNames.videos,
      data: video.toJson(),
      documentId: videoId,
    );

    return video;
  }
}
