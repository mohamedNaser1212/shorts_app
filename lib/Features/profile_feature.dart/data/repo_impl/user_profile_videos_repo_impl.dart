import 'package:dartz/dartz.dart';
import 'package:shorts/Features/profile_feature.dart/data/user_profile_videos_remote_data_source/user_profile_videos_remote_data_source.dart';
import 'package:shorts/Features/profile_feature.dart/domain/repo/user_profile_videos_repo.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/managers/error_manager/failure.dart';
import 'package:shorts/core/managers/repo_manager/repo_manager.dart';

class UserProfileVideosRepoImpl implements UserProfileVideosRepo {
  final UserProfileVideosRemoteDataSource remoteDataSource;
  final RepoManager repoManager;

  UserProfileVideosRepoImpl({
    required this.remoteDataSource,
    required this.repoManager,
  });

  @override
  Future<Either<Failure,List<VideoEntity>>> getUserVideos({
    required String userId
  }) async {
    return repoManager.call(action: () async {
      final videos= await remoteDataSource.getUserVideos(userId: userId);
      return videos;
    });
  }
}
