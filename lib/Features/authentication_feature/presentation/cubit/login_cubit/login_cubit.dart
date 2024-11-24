import 'dart:async';

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
  Timer? _verificationTimer;

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginCubit({
    required this.loginUseCase,
    required this.userDataUseCase,
    required this.verifyUserUseCase,
  }) : super(LoginState());

  void startVerificationListener({
    required String userId,
  }) {
    emit(VerificationLoadingState());
    _verificationTimer =
        Timer.periodic(const Duration(seconds: 3), (timer) async {
      final verificationResult = await verifyUserUseCase.call(userId: userId);

      verificationResult.fold(
        (failure) {
          emit(VerificationErrorState(errMessage: failure.message));
        },
        (isVerified) {
          if (isVerified) {
            timer.cancel();
            emit(VerificationSuccessState(
              isVerified: isVerified,
            ));
          }
        },
      );
    });
  }

  void stopVerificationListener() {
    _verificationTimer?.cancel();
  }

  Future<void> login({
    required LoginRequestModel requestModel,
  }) async {
    emit(LoginLoadingState());

    final loginResult = await loginUseCase.call(requestModel: requestModel);
    loginResult.fold(
      (failure) {
        emit(LoginErrorState(error: failure.message));
      },
      (success) async {
        final userDataResult = await userDataUseCase.call();
        userDataResult.fold(
          (failure) {
            emit(LoginErrorState(error: failure.message));
          },
          (userData) {
            emit(LoginSuccessState(userEntity: userData!));

            startVerificationListener(userId: userData.id!);
          },
        );
      },
    );
  }

  @override
  Future<void> close() {
    stopVerificationListener();
    return super.close();
  }
}
