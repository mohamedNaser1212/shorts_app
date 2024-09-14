import 'package:dartz/dartz.dart';

import '../../../../core/error_manager/failure.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';

abstract class AuthenticationRepo {
  const AuthenticationRepo();
  Future<Either<Failure, UserEntity>> login(
      {required String email, required String password});
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  });
}
