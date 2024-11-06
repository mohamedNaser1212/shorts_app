import 'package:dartz/dartz.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../authentication_repo/authentication_repo.dart';

class GoogleSignInUseCase {
  final AuthenticationRepo repository;

  GoogleSignInUseCase({
    required this.repository,
  });

  Future<Either<Failure, UserEntity>> call() async {
    return repository.signInWithGoogle();
  }
}
