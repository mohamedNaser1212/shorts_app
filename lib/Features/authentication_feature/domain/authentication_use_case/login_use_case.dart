import 'package:dartz/dartz.dart';

import '../../../../core/error_manager/failure.dart';
import '../../data/user_model/user_model.dart';
import '../authentication_repo/authentication_repo.dart';

class LoginUseCase {
  final AuthenticationRepo authenticationRepo;

  const LoginUseCase({required this.authenticationRepo});

  Future<Either<Failure, UserModel>> call({
    required String email,
    required String password,
  }) async {
    return await authenticationRepo.login(email: email, password: password);
  }
}
