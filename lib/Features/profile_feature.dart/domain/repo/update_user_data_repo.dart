import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shorts/core/managers/error_manager/failure.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

import '../models/update_request_model.dart';

abstract class UpdateUserDataRepo {
  const UpdateUserDataRepo();
  // Future<Either<Failure, UserEntity>> getUserData();
  Future<Either<Failure, UserEntity>> updateUserData({
    required UpdateUserRequestModel updateUserRequestModel,
    required String userId,
    required File imageFile,
  });

  // Future<Either<Failure, bool>> signOut();
}
