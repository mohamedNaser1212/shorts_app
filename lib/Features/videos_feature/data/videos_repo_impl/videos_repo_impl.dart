import 'package:dartz/dartz.dart';
import 'package:shorts/Features/videos_feature/data/data_sources/videos_local_data_source/video_local_data_source.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/videos_feature/domain/video_repo/video_repo.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../../../../core/managers/repo_manager/repo_manager.dart';
import '../data_sources/video_remote_data_source/videos_rermote_data_source.dart';

class VideosRepoImpl extends VideosRepo {
  final VideosRemoteDataSource videosRemoteDataSource;
  final VideoLocalDataSource videoLocalDataSource;
  final RepoManager repoManager;

  VideosRepoImpl({
    required this.videosRemoteDataSource,
    required this.videoLocalDataSource,
    required this.repoManager,
  });

  @override
  Future<Either<Failure, List<VideoEntity>>> getVideos() async {
    return repoManager.call(action: () async {
      // final cachedVideos = await videoLocalDataSource.getVideos();

      final videos = await videosRemoteDataSource.getVideos();
      await videoLocalDataSource.saveVideos(videos);
      print('videos: ${videos.length}');
      return videos;
    });
  }

  @override
  Future<Either<Failure, VideoEntity>> uploadVideo({
    required VideoModel videoModel,
    UserEntity? sharedBy,
  }) {
    return repoManager.call(action: () async {
      final video = await videosRemoteDataSource.uploadVideo(
          videoModel: videoModel, sharedBy: sharedBy);
      return video;
    });
  }

  @override
  Future<Either<Failure, void>> shareVideo(
      {required VideoModel model,
      required String text,
      required UserEntity user}) {

    return repoManager.call(action: () async {
      await videosRemoteDataSource.shareVideo(
        model: model,
        text: text,
        user: user,
      );
    });
    
   
  }
}
