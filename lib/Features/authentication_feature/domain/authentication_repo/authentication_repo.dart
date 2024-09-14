import 'package:dartz/dartz.dart';

import '../../../../core/error_manager/failure.dart';
import '../../data/user_model/user_model.dart';

abstract class AuthenticationRepo {
  const AuthenticationRepo();
  Future<Either<Failure, UserModel>> login(
      {required String email, required String password});
  Future<Either<Failure, UserModel>> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  });
}
