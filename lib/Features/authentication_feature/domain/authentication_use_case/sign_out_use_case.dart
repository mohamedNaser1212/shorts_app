import 'package:dartz/dartz.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../authentication_repo/authentication_repo.dart';

class SignOutUseCase {
  final AuthenticationRepo authenticationRepo;

  const SignOutUseCase({required this.authenticationRepo});

  Future<Either<Failure, bool>> call() async {
    return await authenticationRepo.signOut();
  }
}
