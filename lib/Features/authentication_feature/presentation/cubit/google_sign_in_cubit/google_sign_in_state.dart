part of 'google_sign_in_cubit.dart';

class GoogleSignInState {}

class GoogleSignInInitial extends GoogleSignInState {}

class GoogleSignInLoadingState extends GoogleSignInState {}

class GoogleSignInSuccessState extends GoogleSignInState {
  final UserEntity userEntity;

  GoogleSignInSuccessState({
    required this.userEntity,
  });
}

class GoogleSignInErrorState extends GoogleSignInState {
  final String failure;

  GoogleSignInErrorState({
    required this.failure,
  });
}

class VerificationLoadingState extends GoogleSignInState {}

class VerificationSuccessState extends GoogleSignInState {
  final bool isVerified;

  VerificationSuccessState({
    required this.isVerified,
  });
}

class VerificationErrorState extends GoogleSignInState {
  final String errMessage;

  VerificationErrorState({
    required this.errMessage,
  });
}
