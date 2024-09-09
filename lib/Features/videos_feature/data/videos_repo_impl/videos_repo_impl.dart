import 'package:dartz/dartz.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/Features/videos_feature/data/video_remote_data_source/videos_rermote_data_source.dart';
import 'package:shorts/Features/videos_feature/domain/video_repo/video_repo.dart';
import 'package:shorts/core/error_manager/failure.dart';
import 'package:shorts/core/error_manager/server_failure.dart';

class VideosRepoImpl extends VideosRepo {
  final VideosRemoteDataSource videosRemoteDataSource;

  VideosRepoImpl({required this.videosRemoteDataSource});

  @override
  Future<Either<Failure, List<VideoModel>>> getVideos() async {
    try {
      final videos = await videosRemoteDataSource.getVideos();
      return Right(videos);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, VideoModel>> uploadVideo({
    required String description,
    required String videoPath,
  }) async {
    try {
      final video = await videosRemoteDataSource.uploadVideo(
        videoPath: videoPath,
        description: description,
      );
      return Right(video);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
      ));
    }
  }
}
