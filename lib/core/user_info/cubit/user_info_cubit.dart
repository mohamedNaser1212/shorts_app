import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/authentication_feature/data/user_model/user_model.dart';

import '../domain/use_cases/get_user_info_use_case.dart';
import '../domain/user_entity/user_entity.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit({
    required this.getUserUseCase,
  }) : super(UserInfoState());

  static UserInfoCubit get(context) => BlocProvider.of(context);

  final GetUserInfoUseCase getUserUseCase;
  UserEntity? userEntity;
  UserModel? userModel;

  Future<void> getUserData() async {
    emit(GetUserInfoLoadingState());
    final result = await getUserUseCase.call();
    result.fold(
      (failure) {
        print(failure.message);
        emit(GetUserInfoErrorState(message: failure.message));
      },
      (user) {
   
   
        print(userModel?.name);
        userEntity = user;
       
       
        emit(GetUserInfoSuccessState(userEntity: userEntity));
      },
    );
  }
}
