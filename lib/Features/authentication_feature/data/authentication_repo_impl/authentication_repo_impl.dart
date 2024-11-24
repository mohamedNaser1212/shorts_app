import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../../../../core/managers/repo_manager/repo_manager.dart';
import '../../../../core/user_info/data/user_info_data_sources/user_info_local_data_source.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../domain/authentication_repo/authentication_repo.dart';
import '../authentication_data_sources/authentication_remote_data_source.dart';
import '../user_model/login_request_model.dart';
import '../user_model/register_request_model.dart';

class AuthRepoImpl implements AuthenticationRepo {
  final AuthenticationRemoteDataSource loginDataSource;
  final UserInfoLocalDataSource userInfoLocalDataSource;
  final RepoManager repoManager;

  const AuthRepoImpl({
    required this.loginDataSource,
    required this.userInfoLocalDataSource,
    required this.repoManager,
  });

  @override
  Future<Either<Failure, UserEntity>> login({
    required LoginRequestModel requestModel,
  }) {
    return repoManager.call(
      action: () async {
        final loginEntity = await loginDataSource.login(
          requestModel: requestModel,
        );
        await userInfoLocalDataSource.saveUserData(user: loginEntity);
        return loginEntity;
      },
    );
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required RegisterRequestModel requestModel,
    required File imageFile,
  }) {
    return repoManager.call(
      action: () async {
        final registerEntity = await loginDataSource.register(
          requestModel: requestModel,
          imageFile: imageFile,
        );
        await userInfoLocalDataSource.saveUserData(user: registerEntity);
        return registerEntity;
      },
    );
  }

  @override
  Future<Either<Failure, bool>> signOut() {
    return repoManager.call(
      action: () async {
        final result = await loginDataSource.signOut();
        await userInfoLocalDataSource.clearUserData();
        return result;
      },
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() {
    return repoManager.call(
      action: () async {
        final googleEntity = await loginDataSource.signInWithGoogle();
        await userInfoLocalDataSource.saveUserData(user: googleEntity);
        return googleEntity;
      },
    );
  }

  @override
  Future<Either<Failure, bool>> verifyUser({required String userId}) async {
    return repoManager.call(
      action: () async {
        return await loginDataSource.verifyUser(userId: userId);
      },
    );
  }
}
