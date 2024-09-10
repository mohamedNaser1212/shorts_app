import 'package:dartz/dartz.dart';

import '../../../../core/error_manager/failure.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../authentication_repo/authentication_repo.dart';

class RegisterUseCase {
  final AuthenticationRepo authenticationRepo;

  const RegisterUseCase({required this.authenticationRepo});

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    return await authenticationRepo.register(
        email: email, password: password, name: name, phone: phone);
  }
}
