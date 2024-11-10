import 'package:dartz/dartz.dart';
import 'package:shorts/Features/profile_feature.dart/data/user_profile_videos_remote_data_source/user_profile_videos_remote_data_source.dart';
import 'package:shorts/Features/profile_feature.dart/domain/repo/user_profile_videos_repo.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/managers/error_manager/failure.dart';
import 'package:shorts/core/managers/repo_manager/repo_manager.dart';

class UserProfileRepoImpl implements UserProfileRepo {
  final UserProfilesRemoteDataSource remoteDataSource;
  final RepoManager repoManager;

  UserProfileRepoImpl({
    required this.remoteDataSource,
    required this.repoManager,
  });

  @override
  Future<Either<Failure, List<VideoEntity>>> getUserVideos(
      {required String userId}) async {
    return repoManager.call(action: () async {
      final videos = await remoteDataSource.getUserVideos(userId: userId);
      return videos;
    });
  }

  @override
  Future<Either<Failure, void>> followUser({
    required String currentUserId,
    required String targetUserId,
  }) async {
    return repoManager.call(action: () async {
      await remoteDataSource.followUser(
          currentUserId: currentUserId, targetUserId: targetUserId);
      return null;
    });
  }

  @override
  Future<Either<Failure, void>> unfollowUser({
    required String currentUserId,
    required String targetUserId,
  }) async {
    return repoManager.call(action: () async {
      await remoteDataSource.unfollowUser(
          currentUserId: currentUserId, targetUserId: targetUserId);
    });
  }

  @override
  Future<Either<Failure, int>> getFollowersCount({
    required String userId,
  }) async {
    return repoManager.call(action: () async {
      final count = await remoteDataSource.getFollowersCount(userId: userId);
      return count;
    });
  }

  @override
  Future<Either<Failure, int>> getFollowingCount({
    required String userId,
  }) async {
    return repoManager.call(action: () async {
      final count = await remoteDataSource.getFollowingCount(userId: userId);
      return count;
    });
  }
}
