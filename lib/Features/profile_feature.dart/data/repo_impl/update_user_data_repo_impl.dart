import 'package:dartz/dartz.dart';
import 'package:shorts/Features/profile_feature.dart/domain/repo/update_user_data_repo.dart';
import 'package:shorts/core/managers/error_manager/failure.dart';
import 'package:shorts/core/managers/repo_manager/repo_manager.dart';
import 'package:shorts/core/user_info/data/user_info_data_sources/user_info_local_data_source.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

import '../../domain/models/update_request_model.dart';
import '../data_sources/user_profile_remote_data_source/update_user_data_remote_data_source.dart';

class UpdateUserDataRepoImpl extends UpdateUserDataRepo {
  final RepoManager repoManager;
  final UpdateUserDataRemoteDataSource updateUserDataSource;
  final UserInfoLocalDataSource userInfoLocalDataSource;

  const UpdateUserDataRepoImpl({
    required this.repoManager,
    required this.updateUserDataSource,
    required this.userInfoLocalDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> updateUserData({
    required UpdateUserRequestModel updateUserRequestModel,
    required String userId,
  }) async {
    return repoManager.call(
      action: () async {
        final cachedUserData = await updateUserDataSource.updateUserData(
          updateUserRequestModel: updateUserRequestModel,
          userId: userId,
        );
        await userInfoLocalDataSource.saveUserData(user: cachedUserData);
        return cachedUserData;
      },
    );
  }
}
