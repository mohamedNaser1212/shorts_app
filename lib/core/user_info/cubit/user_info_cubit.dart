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
        // userModel = UserModel(
        //   id: user!.id,
        //   name: user.name,
        //   email: user.email,
        //   phone: user.phone,
        //   fcmToken: user.fcmToken,
        // );
        print(userModel?.name);
        userEntity = user;
        // print(userEntity?.name);
        // print(userEntity?.id);
        // print(userEntity?.phone);
        // print(userEntity?.email);
        // print(userEntity?.fcmToken);
        emit(GetUserInfoSuccessState(userModel: userEntity));
      },
    );
  }
}
