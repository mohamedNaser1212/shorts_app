import 'package:dartz/dartz.dart';

import '../../../error_manager/failure.dart';
import '../user_entity/user_entity.dart';
import '../user_info_repo/user_info_repo.dart';

class GetUserInfoUseCase {
  final UserInfoRepo userInfoRepo;

  const GetUserInfoUseCase({
    required this.userInfoRepo,
  });

  Future<Either<Failure, UserEntity?>> call() async {
    return await userInfoRepo.getUser();
  }
}
