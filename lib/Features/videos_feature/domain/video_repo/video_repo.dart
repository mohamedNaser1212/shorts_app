import 'package:dartz/dartz.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/core/error_manager/failure.dart';

abstract class VideosRepo {
  Future<Either<Failure, List<VideoModel>>> getVideos();
  Future<Either<Failure, VideoModel>> uploadVideo();
}
