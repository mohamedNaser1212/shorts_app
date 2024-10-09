import 'package:dartz/dartz.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';

import '../../../../core/managers/error_manager/failure.dart';

abstract class VideosRepo {
  const VideosRepo();
  Future<Either<Failure, List<VideoModel>>> getVideos();
  Future<Either<Failure, VideoModel>> uploadVideo({
        required VideoModel videoModel,

  });
}
