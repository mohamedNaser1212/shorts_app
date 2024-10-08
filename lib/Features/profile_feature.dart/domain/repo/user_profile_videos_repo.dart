import 'package:dartz/dartz.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/managers/error_manager/failure.dart';

abstract class UserProfileVideosRepo {
  Future<Either<Failure,List<VideoEntity>>>  getUserVideos({
    required String userId
  });
}
