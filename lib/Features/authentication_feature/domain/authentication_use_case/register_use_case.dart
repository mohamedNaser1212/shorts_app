import 'package:dartz/dartz.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../data/user_model/register_request_model.dart';
import '../authentication_repo/authentication_repo.dart';

class RegisterUseCase {
  final AuthenticationRepo authenticationRepo;

  const RegisterUseCase({required this.authenticationRepo});

  Future<Either<Failure, UserEntity>> call({
    required RegisterRequestModel requestModel,
  }) async {
    return await authenticationRepo.register(
      requestModel: requestModel,
    );
  }
}
