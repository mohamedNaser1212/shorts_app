import 'package:dartz/dartz.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../authentication_repo/authentication_repo.dart';

class VerifyUserUseCase {
  final AuthenticationRepo authenticationRepo;

  const VerifyUserUseCase({required this.authenticationRepo});

  Future<Either<Failure, bool>> call({
    required String userId,
  }) async {
    return await authenticationRepo.verifyUser(userId: userId);
  }
}
