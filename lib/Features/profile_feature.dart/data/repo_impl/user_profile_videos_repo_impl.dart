import 'package:dartz/dartz.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../../../../core/managers/repo_manager/repo_manager.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../../videos_feature/domain/video_entity/video_entity.dart';
import '../../domain/repo/user_profile_videos_repo.dart';
import '../user_profile_videos_remote_data_source/user_profile_videos_remote_data_source.dart';

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
  Future<Either<Failure, UserEntity>> toggleFollow({
    required String currentUserId,
    required String targetUserId,
    required String targetUserName,
  }) async {
    return repoManager.call(action: () async {
      final userEntity = await remoteDataSource.toggleFollow(
        currentUserId: currentUserId,
        targetUserId: targetUserId,
        targetUserName: targetUserName,
      );
      return userEntity;
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

  @override
  Future<Either<Failure, bool>> isUserFollowed({
    required String currentUserId,
    required String targetUserId,
  }) async {
    return repoManager.call(action: () async {
      final count = await remoteDataSource.isUserFollowed(
          currentUserId: currentUserId, targetUserId: targetUserId);
      return count;
    });
  }
}
