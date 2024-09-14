import 'package:dartz/dartz.dart';

import '../../../error_manager/failure.dart';
import '../user_entity/user_entity.dart';

abstract class UserInfoRepo {
  const UserInfoRepo();

  Future<Either<Failure, UserEntity?>> getUser();
}
