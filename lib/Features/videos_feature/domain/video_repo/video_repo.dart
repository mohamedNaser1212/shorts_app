import 'package:dartz/dartz.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/core/error_manager/failure.dart';

import '../../../authentication_feature/data/user_model/user_model.dart';

abstract class VideosRepo {
  Future<Either<Failure, List<VideoModel>>> getVideos();
  Future<Either<Failure, VideoModel>> uploadVideo({
    required String description,
    required String videoPath,
    required UserModel user,
  });
}
