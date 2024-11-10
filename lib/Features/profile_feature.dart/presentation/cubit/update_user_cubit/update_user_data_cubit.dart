import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/domain/use_case/update_user_data_use_case.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

import '../../../domain/models/update_request_model.dart';

part 'update_user_data_state.dart';

class UpdateUserDataCubit extends Cubit<UpdateUserDataState> {
  UpdateUserDataCubit({
    required this.updateUserDataUseCase,
  }) : super(UpdateUserDataState());
  static UpdateUserDataCubit get(context) => BlocProvider.of(context);
  final UpdateUserDataUseCase updateUserDataUseCase;

  UserEntity? userEntity;

  bool checkDataChanges(
      {required String name,
      required String email,
      required String phone,
      required String imageUrl}) {
    return userEntity != null &&
        (name != userEntity!.name ||
            email != userEntity!.email ||
            phone != userEntity!.phone ||
            imageUrl != userEntity!.profilePic);
  }

  Future<void> updateUserData({
    required UpdateUserRequestModel updateUserRequestModel,
    required String userId,
  }) async {
    emit(UpdateUserDataLoadingState());
    final result = await updateUserDataUseCase(
      updateUserRequestModel: updateUserRequestModel,
      userId: userId,
    );
    result.fold(
      (failure) {
        print(failure.message);
        emit(UpdateUserDataErrorState(message: failure.message));
      },
      (userEntity) {
        emit(UpdateUserDataSuccessState(userEntity: userEntity));
      },
    );
  }
}
