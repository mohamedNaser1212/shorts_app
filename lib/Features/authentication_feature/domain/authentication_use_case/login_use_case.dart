import 'package:dartz/dartz.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../data/user_model/login_request_model.dart';
import '../authentication_repo/authentication_repo.dart';

class LoginUseCase {
  final AuthenticationRepo authenticationRepo;

  const LoginUseCase({required this.authenticationRepo});

  Future<Either<Failure, UserEntity>> call({
    required LoginRequestModel requestModel,
  }) async {
    return await authenticationRepo.login(requestModel: requestModel);
  }
}
