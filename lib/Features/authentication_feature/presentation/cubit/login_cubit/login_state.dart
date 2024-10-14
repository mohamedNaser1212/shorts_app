import '../../../../../core/user_info/domain/user_entity/user_entity.dart';

class LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final UserEntity userModel;
  LoginSuccessState({
    required this.userModel,
  });
}

class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState({
    required this.error,
  });
}

class AppChangePasswordVisibilityState extends LoginState {}

