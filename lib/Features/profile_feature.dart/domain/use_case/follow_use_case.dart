import 'package:dartz/dartz.dart';
import 'package:shorts/Features/profile_feature.dart/domain/repo/user_profile_videos_repo.dart';
import 'package:shorts/core/managers/error_manager/failure.dart';

class FollowUserUseCase {
  final UserProfileRepo repository;

  FollowUserUseCase({required this.repository});

  Future<Either<Failure, void>> call({
    required String currentUserId,
    required String targetUserId,
  }) async {
    return await repository.followUser(
      currentUserId: currentUserId,
      targetUserId: targetUserId,
    );
  }
}
