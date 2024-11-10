import 'package:dartz/dartz.dart';
import 'package:shorts/Features/profile_feature.dart/domain/repo/user_profile_videos_repo.dart';
import 'package:shorts/core/managers/error_manager/failure.dart';

class IsUserFollowedUseCase {
  final UserProfileRepo repository;

  IsUserFollowedUseCase({required this.repository});

  Future<Either<Failure, bool>> isUserFollowed({
    required String currentUserId,
    required String targetUserId,
  }) async {
    return await repository.isUserFollowed(
      currentUserId: currentUserId,
      targetUserId: targetUserId,
    );
  }
}
