import 'package:dartz/dartz.dart';

import '../../../../Features/authentication_feature/data/user_model/user_model.dart';
import '../../../error_manager/failure.dart';

abstract class UserInfoRepo {
  const UserInfoRepo();

  Future<Either<Failure, UserModel?>> getUser();
}
