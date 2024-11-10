import 'package:dartz/dartz.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/managers/error_manager/failure.dart';

abstract class UserProfileRepo {
  Future<Either<Failure, List<VideoEntity>>> getUserVideos(
      {required String userId});
  Future<Either<Failure, void>> followUser(
      {required String currentUserId, required String targetUserId});
  Future<Either<Failure, void>> unfollowUser(
      {required String currentUserId, required String targetUserId});
  Future<Either<Failure, int>> getFollowersCount({
    required String userId,
  });
  Future<Either<Failure, int>> getFollowingCount({
    required String userId,
  });
}
