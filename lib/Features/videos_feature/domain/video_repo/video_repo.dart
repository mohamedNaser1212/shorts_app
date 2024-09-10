import 'package:dartz/dartz.dart';
import 'package:shorts/core/error_manager/failure.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../video_entity/video_entity.dart';

abstract class VideosRepo {
  Future<Either<Failure, List<VideoEntity>>> getVideos();
  Future<Either<Failure, VideoEntity>> uploadVideo({
    required String description,
    required String videoPath,
    required UserEntity user,
  });
}
