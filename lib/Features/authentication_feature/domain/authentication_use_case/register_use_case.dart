import 'package:dartz/dartz.dart';

import '../../../../core/error_manager/failure.dart';
import '../../data/user_model/user_model.dart';
import '../authentication_repo/authentication_repo.dart';

class RegisterUseCase {
  final AuthenticationRepo authenticationRepo;

  const RegisterUseCase({required this.authenticationRepo});

  Future<Either<Failure, UserModel>> call({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    return await authenticationRepo.register(
        email: email, password: password, name: name, phone: phone);
  }
}
