part of 'register_cubit.dart';

class RegisterState {}

class RegisterSuccessState extends RegisterState {
  final UserEntity userModel;

  RegisterSuccessState({required this.userModel});
}

class RegisterLoadingState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String message;

  RegisterErrorState({required this.message});
}

class RegisterChangePasswordVisability extends RegisterState {}
