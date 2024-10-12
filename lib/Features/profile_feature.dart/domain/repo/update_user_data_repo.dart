import 'package:dartz/dartz.dart';
import 'package:shorts/Features/profile_feature.dart/domain/update_model/update_request_model.dart';
import 'package:shorts/core/managers/error_manager/failure.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

abstract class UpdateUserDataRepo {
  const UpdateUserDataRepo();
  // Future<Either<Failure, UserEntity>> getUserData();
  Future<Either<Failure, UserEntity>> updateUserData({
    required UpdateUserRequestModel updateUserRequestModel,
    required String userId,
  });

  // Future<Either<Failure, bool>> signOut();
}
