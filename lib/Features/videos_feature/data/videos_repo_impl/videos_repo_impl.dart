import 'package:dartz/dartz.dart';
import 'package:shorts/Features/videos_feature/data/data_sources/videos_local_data_source/video_local_data_source.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/Features/videos_feature/domain/video_repo/video_repo.dart';
import 'package:shorts/core/error_manager/failure.dart';
import 'package:shorts/core/repo_manager/repo_manager.dart';

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
  Future<Either<Failure, List<VideoModel>>> getVideos() async {
    return repoManager.call(action: () async {
      final videos = await videosRemoteDataSource.getVideos();
      await videoLocalDataSource.saveVideos(videos);
      return videos;
    });
  }

  @override
  Future<Either<Failure, VideoModel>> uploadVideo(
      {required String description, required String videoPath}) {
    return repoManager.call(action: () async {
      final video = await videosRemoteDataSource.uploadVideo(
        videoPath: videoPath,
        description: description,
      );
      return video;
    });
  }
}
