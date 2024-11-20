import 'package:dartz/dartz.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<UserEntity>>> search({
    required String query,
    required int page,
  });
}
