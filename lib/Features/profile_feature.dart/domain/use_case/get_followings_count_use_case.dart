import 'package:dartz/dartz.dart';
import 'package:shorts/core/managers/error_manager/failure.dart';
import 'package:shorts/Features/profile_feature.dart/domain/repo/user_profile_videos_repo.dart';

class GetFollowingCountUseCase {
  final UserProfileRepo repository;

  GetFollowingCountUseCase({required this.repository});

  Future<Either<Failure, int>> call({
    required String userId,
  }) async {
    return await repository.getFollowingCount(userId: userId);
  }
}
