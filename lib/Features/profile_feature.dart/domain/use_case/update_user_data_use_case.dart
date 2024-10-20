import 'package:dartz/dartz.dart';
import 'package:shorts/Features/profile_feature.dart/domain/repo/update_user_data_repo.dart';
import 'package:shorts/Features/profile_feature.dart/domain/update_model/update_request_model.dart';
import 'package:shorts/core/managers/error_manager/failure.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

class UpdateUserDataUseCase {
  final UpdateUserDataRepo updateRepo;

  UpdateUserDataUseCase({required this.updateRepo});

  Future<Either<Failure, UserEntity>> call({
    required UpdateUserRequestModel updateUserRequestModel,
    required String userId,
  }) async {
    return await updateRepo.updateUserData(
      updateUserRequestModel: updateUserRequestModel,
      userId: userId,
    );
  }
}
