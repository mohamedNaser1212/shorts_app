import '../../../../../core/user_info/domain/user_entity/user_entity.dart';

class LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final UserEntity userEntity;
  LoginSuccessState({
    required this.userEntity,
  });
}

class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState({
    required this.error,
  });
}

class LoginVerificationRequiredState extends LoginState {}

class AppChangePasswordVisibilityState extends LoginState {}

class VerificationLoadingState extends LoginState {}

class VerificationSuccessState extends LoginState {
  final bool isVerified;

  VerificationSuccessState({
    required this.isVerified,
  });
}

class VerificationErrorState extends LoginState {
  final String errMessage;

  VerificationErrorState({
    required this.errMessage,
  });
}
