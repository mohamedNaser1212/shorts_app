import 'package:dartz/dartz.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/managers/error_manager/failure.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

abstract class UserProfileRepo {
  Future<Either<Failure, List<VideoEntity>>> getUserVideos({
    required String userId,
  });
  Future<Either<Failure, UserEntity>> toggleFollow({
    required String currentUserId,
    required String targetUserId,
  });

  Future<Either<Failure, int>> getFollowersCount({
    required String userId,
  });
  Future<Either<Failure, int>> getFollowingCount({
    required String userId,
  });
  Future<Either<Failure, bool>> isUserFollowed({
    required String currentUserId,
    required String targetUserId,
  });
}
