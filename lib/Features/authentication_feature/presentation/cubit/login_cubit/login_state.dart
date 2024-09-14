import 'package:shorts/Features/authentication_feature/data/user_model/user_model.dart';

class LoginState {}

class AppLoginLoadingState extends LoginState {}

class AppLoginSuccessState extends LoginState {
  final UserModel userModel;
  AppLoginSuccessState({
    required this.userModel,
  });
}

class AppLoginErrorState extends LoginState {
  final String error;
  AppLoginErrorState({
    required this.error,
  });
}

class AppChangePasswordVisibilityState extends LoginState {}
