import 'package:dartz/dartz.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../video_entity/video_entity.dart';

abstract class VideosRepo {
  const VideosRepo();

  Future<Either<Failure, List<VideoEntity>>> getVideos();

  Future<Either<Failure, VideoEntity>> uploadVideo({
    required VideoModel videoModel,
  });

  Future<Either<Failure, void>> shareVideo({
    required VideoModel model,
    required String text,
    required UserEntity user,
  });
}
