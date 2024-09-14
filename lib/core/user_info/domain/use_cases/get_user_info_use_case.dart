import 'package:dartz/dartz.dart';

import '../../../../Features/authentication_feature/data/user_model/user_model.dart';
import '../../../error_manager/failure.dart';
import '../user_info_repo/user_info_repo.dart';

class GetUserInfoUseCase {
  final UserInfoRepo userInfoRepo;

  const GetUserInfoUseCase({
    required this.userInfoRepo,
  });

  Future<Either<Failure, UserModel?>> call() async {
    return await userInfoRepo.getUser();
  }
}
