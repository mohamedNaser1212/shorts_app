import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../../../../core/managers/repo_manager/repo_manager.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../../videos_feature/domain/video_entity/video_entity.dart';
import '../../domain/repo/user_profile_videos_repo.dart';
import '../data_sources/user_profile_remote_data_source/user_profile_remote_data_source.dart';
import '../data_sources/user_profile_videos_local_data_source/user_profile_videos_local_data_source.dart';

class UserProfileRepoImpl implements UserProfileRepo {
  final UserProfilesRemoteDataSource remoteDataSource;
  final RepoManager repoManager;
  final UserVideosLocalDataSource localDataSource;

  UserProfileRepoImpl({
    required this.remoteDataSource,
    required this.repoManager,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<VideoEntity>>> getUserVideos({
    required String userId,
    DocumentSnapshot? lastVisible,
  }) async {
    return repoManager.call(action: () async {
      final videos = await remoteDataSource.getUserVideos(
        userId: userId,
      );
      await localDataSource.saveUserVideos(
        videos: videos,
      );
      return videos;
    });
  }

  @override
  Future<Either<Failure, UserEntity>> toggleFollow({
    required String currentUserId,
    required String targetUserId,
  }) async {
    return repoManager.call(action: () async {
      final userEntity = await remoteDataSource.toggleFollow(
        currentUserId: currentUserId,
        targetUserId: targetUserId,
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
