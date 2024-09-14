import 'package:dartz/dartz.dart';
import 'package:shorts/core/error_manager/failure.dart';
import 'package:shorts/core/repo_manager/repo_manager.dart';

import '../../../../core/user_info/data/user_info_data_sources/user_info_local_data_source.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../domain/authentication_repo/authentication_repo.dart';
import '../authentication_data_sources/authentication_remote_data_source.dart';

class AuthRepoImpl implements AuthenticationRepo {
  final AuthenticationRemoteDataSource loginDataSource;
  final UserInfoLocalDataSource userInfoLocalDataSourceImpl;
  final RepoManager repoManager;

  const AuthRepoImpl({
    required this.loginDataSource,
    required this.userInfoLocalDataSourceImpl,
    required this.repoManager,
  });

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) {
    return repoManager.call(
      action: () async {
        final loginEntity = await loginDataSource.login(
          email: email,
          password: password,
        );
        await userInfoLocalDataSourceImpl.saveUserData(user: loginEntity);
        return loginEntity;
      },
    );
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    return repoManager.call(
      action: () async {
        final registerEntity = await loginDataSource.register(
          email: email,
          password: password,
          name: name,
          phone: phone,
        );
        await userInfoLocalDataSourceImpl.saveUserData(user: registerEntity);
        return registerEntity;
      },
    );
  }
}
