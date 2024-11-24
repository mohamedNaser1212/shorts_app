part of 'register_cubit.dart';

class RegisterState {}

class RegisterSuccessState extends RegisterState {
  final UserEntity userEntity;
  RegisterSuccessState({required this.userEntity});
}

class RegisterLoadingState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String message;
  RegisterErrorState({required this.message});
}

class RegisterVerificationRequiredState extends RegisterState {
  final UserEntity userEntity;
  RegisterVerificationRequiredState({required this.userEntity});
}

class RegisterChangePasswordVisibility extends RegisterState {}

class VerificationLoadingState extends RegisterState {}

class VerificationSuccessState extends RegisterState {
  final bool isVerified;

  VerificationSuccessState({
    required this.isVerified,
  });
}

class VerificationErrorState extends RegisterState {
  final String errMessage;

  VerificationErrorState({
    required this.errMessage,
  });
}
