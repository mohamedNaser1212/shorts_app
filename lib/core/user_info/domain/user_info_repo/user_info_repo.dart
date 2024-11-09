import 'package:dartz/dartz.dart';

import '../../../../Features/authentication_feature/data/user_model/user_model.dart';
import '../../../managers/error_manager/failure.dart';
import '../user_entity/user_entity.dart';

abstract class UserInfoRepo {
  const UserInfoRepo._();

  Future<Either<Failure, UserEntity?>> getUser();
  Future<Either<Failure, UserModel>> getUserById({required String uId});
}
