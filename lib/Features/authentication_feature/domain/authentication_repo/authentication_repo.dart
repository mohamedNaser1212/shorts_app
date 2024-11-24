import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../data/user_model/login_request_model.dart';
import '../../data/user_model/register_request_model.dart';

abstract class AuthenticationRepo {
  const AuthenticationRepo._();
  Future<Either<Failure, UserEntity>> login({
    required LoginRequestModel requestModel,
  });
  Future<Either<Failure, UserEntity>> register({
    required RegisterRequestModel requestModel,
    required File imageFile,
  });
  Future<Either<Failure, bool>> signOut();
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, bool>> verifyUser({
    required String userId,
  });
}
