import 'package:dartz/dartz.dart';

import '../../../../core/error_manager/failure.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../authentication_repo/authentication_repo.dart';

class LoginUseCase {
  final AuthenticationRepo authenticationRepo;

  const LoginUseCase({required this.authenticationRepo});

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
  }) async {
    return await authenticationRepo.login(email: email, password: password);
  }
}
