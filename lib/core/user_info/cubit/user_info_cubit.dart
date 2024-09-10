import 'package:flutter_bloc/flutter_bloc.dart';

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

  Future<void> getUserData() async {
    emit(GetUserInfoLoadingState());
    final result = await getUserUseCase.call();
    result.fold(
      (failure) {
        print(failure.message);
        emit(GetUserInfoErrorState(message: failure.message));
      },
      (user) {
        userEntity = user;
        print(userEntity?.name);
        print(userEntity?.id);
        print(userEntity?.phone);
        print(userEntity?.email);
        emit(GetUserInfoSuccessState(userEntity: userEntity));
      },
    );
  }
}
