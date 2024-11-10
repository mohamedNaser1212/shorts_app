import 'package:dartz/dartz.dart';
import 'package:shorts/Features/profile_feature.dart/domain/repo/user_profile_videos_repo.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/managers/error_manager/failure.dart';

class UserProfileVideosUseCase {
  final UserProfileRepo repository;

  UserProfileVideosUseCase({required this.repository});

  Future<Either<Failure, List<VideoEntity>>> call(
      {required String userId}) async {
    return await repository.getUserVideos(userId: userId);
  }
}
