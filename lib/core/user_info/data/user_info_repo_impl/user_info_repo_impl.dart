import 'package:dartz/dartz.dart';

import '../../../../Features/authentication_feature/data/user_model/user_model.dart';
import '../../../error_manager/failure.dart';
import '../../../repo_manager/repo_manager.dart';
import '../../domain/user_info_repo/user_info_repo.dart';
import '../user_info_data_sources/user_info_local_data_source.dart';
import '../user_info_data_sources/user_info_remote_data_source.dart';

class UserInfoRepoImpl implements UserInfoRepo {
  final UserInfoRemoteDataSource remoteDataSource;
  final UserInfoLocalDataSource userLocalDataSource;
  final RepoManager repoManager;

  const UserInfoRepoImpl({
    required this.remoteDataSource,
    required this.userLocalDataSource,
    required this.repoManager,
  });

  @override
  Future<Either<Failure, UserModel?>> getUser() async {
    return repoManager.call(
      action: () async {
        final UserModel? cachedUserData =
            await userLocalDataSource.loadUserData();

        if (cachedUserData != null) {
          return cachedUserData;
        } else if (cachedUserData == null) {
          return cachedUserData;
        } else {
          final userData = await remoteDataSource.getUser();

          await userLocalDataSource.saveUserData(user: userData);
          return userData;
        }
      },
    );
  }
}
