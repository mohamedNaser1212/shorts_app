part of 'sign_out_cubit.dart';

class SignOutState {}

class SignOutLoadingState extends SignOutState {}

class SignOutSuccessState extends SignOutState {}

class SignOutErrorState extends SignOutState {
  final String error;
  SignOutErrorState({
    required this.error,
  });
}
