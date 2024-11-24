import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/user_info/domain/use_cases/get_user_info_use_case.dart';
import '../../../data/user_model/login_request_model.dart';
import '../../../domain/authentication_use_case/login_use_case.dart';
import '../../../domain/authentication_use_case/verify_user_use_case.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final GetUserInfoUseCase userDataUseCase;
  final VerifyUserUseCase verifyUserUseCase;

  LoginCubit({
    required this.loginUseCase,
    required this.userDataUseCase,
    required this.verifyUserUseCase,
  }) : super(LoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> login({
    required LoginRequestModel requestModel,
  }) async {
    emit(LoginLoadingState());

    final result = await loginUseCase.call(requestModel: requestModel);
    result.fold(
      (failure) {
        emit(LoginErrorState(error: failure.message));
      },
      (success) async {
        final verifyResult =
            await verifyUserUseCase.call(userId: success.id!); // Use the userId
        verifyResult.fold(
          (failure) {
            emit(LoginErrorState(error: failure.message));
          },
          (verifiedUser) async {
            final userDataResult = await userDataUseCase.call();
            userDataResult.fold(
              (failure) {
                emit(LoginErrorState(error: failure.message));
              },
              (userData) {
                emit(
                  LoginSuccessState(
                    userEntity: userData!,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
