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
  final UserInfoLocalDataSource userInfoLocalDataSourceImpl;
  final RepoManager repoManager;

  const AuthRepoImpl({
    required this.loginDataSource,
    required this.userInfoLocalDataSourceImpl,
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
        await userInfoLocalDataSourceImpl.saveUserData(user: loginEntity);
        return loginEntity;
      },
    );
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required RegisterRequestModel requestModel,
  }) {
    return repoManager.call(
      action: () async {
        final registerEntity = await loginDataSource.register(
          requestModel: requestModel,
        );
        await userInfoLocalDataSourceImpl.saveUserData(user: registerEntity);
        return registerEntity;
      },
    );
  }
@override
  Future<Either<Failure, void>> signOut() {
    return repoManager.call(
      action: () async {
        await loginDataSource.signOut(); 
        await userInfoLocalDataSourceImpl.clearUserData(); 
      },
    );
  }
}
