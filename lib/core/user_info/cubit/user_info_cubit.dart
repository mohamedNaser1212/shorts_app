import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/authentication_feature/domain/authentication_use_case/sign_out_use_case.dart';

import '../domain/use_cases/get_user_info_use_case.dart';
import '../domain/user_entity/user_entity.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit({
    required this.getUserUseCase,
    required this.signOutUseCase,
  }) : super(UserInfoState());
  final SignOutUseCase signOutUseCase;

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

        emit(GetUserInfoSuccessState(userEntity: userEntity));
      },
    );
  }

  // UserEntity? selectedUser;
  Future<void> getUserById({
    required String uId,
  }) async {
    emit(GetUserInfoLoadingState());
    final result = await getUserUseCase.getUserById(uId: uId);
    result.fold(
      (failure) {
        print(failure.message);
        emit(GetUserInfoErrorState(message: failure.message));
      },
      (user) {
        // selectedUser = user;

        emit(GetUserInfoSuccessState(userEntity: userEntity));
      },
    );
  }

  Future<void> signOut() async {
    emit(SignOutLoadingState());
    final result = await signOutUseCase.call();
    result.fold(
      (failure) {
        print(failure.message);
        emit(SignOutErrorState(error: failure.message));
      },
      (success) {
        emit(SignOutSuccessState());
      },
    );
  }
}
