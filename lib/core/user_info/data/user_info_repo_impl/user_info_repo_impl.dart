import 'package:dartz/dartz.dart';

import '../../../managers/error_manager/failure.dart';
import '../../../managers/repo_manager/repo_manager.dart';
import '../../domain/user_entity/user_entity.dart';
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
  Future<Either<Failure, UserEntity?>> getUser() async {
    return repoManager.call(
      action: () async {
        final UserEntity? cachedUserData =
            await userLocalDataSource.loadUserData();

        if (cachedUserData != null) {
          final userData = await remoteDataSource.getUser(
            uId: cachedUserData.id ?? '',
          );

          await userLocalDataSource.saveUserData(user: userData);
          return userData;
        } else {
          return null;
        }
      },
    );
  }

  @override
  Future<Either<Failure, UserEntity>> getUserById({required String uId}) {
    return repoManager.call(
      action: () async {
        final userData = await remoteDataSource.getUserById(uId: uId);
        return userData;
      },
    );
  }
}
