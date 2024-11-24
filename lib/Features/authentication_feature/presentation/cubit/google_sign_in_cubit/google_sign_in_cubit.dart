import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../../domain/authentication_use_case/google_sign_in_use_case.dart';
import '../../../domain/authentication_use_case/verify_user_use_case.dart';

part 'google_sign_in_state.dart';

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  GoogleSignInCubit({
    required this.googleSignInUseCase,
    required this.verifyUserUseCase,
  }) : super(GoogleSignInState());
  Timer? _verificationTimer;

  final GoogleSignInUseCase googleSignInUseCase;
  final VerifyUserUseCase verifyUserUseCase;

  static GoogleSignInCubit get(context) => BlocProvider.of(context);
  UserEntity? user;
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

  Future<void> signInWithGoogle() async {
    emit(GoogleSignInLoadingState());
    final result = await googleSignInUseCase.call();
    result.fold(
      (failure) => emit(GoogleSignInErrorState(failure: failure.message)),
      (userEntity) {
        user = userEntity;
        emit(GoogleSignInSuccessState(userEntity: userEntity));
        startVerificationListener(userId: userEntity.id!);
      },
    );
  }

  @override
  Future<void> close() {
    stopVerificationListener();
    return super.close();
  }

  void reset() {
    user = null;
    emit(GoogleSignInState());
  }
}
