import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/user_info/domain/use_cases/get_user_info_use_case.dart';
import '../../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../../data/user_model/register_request_model.dart';
import '../../../domain/authentication_use_case/register_use_case.dart';
import '../../../domain/authentication_use_case/verify_user_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;
  final GetUserInfoUseCase userDataUseCase;
  final VerifyUserUseCase verifyUserUseCase;
  Timer? _verificationTimer;

  static RegisterCubit get(context) => BlocProvider.of(context);

  RegisterCubit({
    required this.registerUseCase,
    required this.userDataUseCase,
    required this.verifyUserUseCase,
  }) : super(RegisterState());

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

  Future<void> registerUser({
    required RegisterRequestModel requestModel,
    required File imageFile,
  }) async {
    emit(RegisterLoadingState());

    final user = await registerUseCase.call(
      requestModel: requestModel,
      imageFile: imageFile,
    );
    user.fold(
      (failure) {
        emit(RegisterErrorState(message: failure.message));
      },
      (success) async {
        emit(RegisterSuccessState(userEntity: success));
        startVerificationListener(userId: success.id!);
      },
    );
  }

  @override
  Future<void> close() {
    stopVerificationListener();
    return super.close();
  }
}
