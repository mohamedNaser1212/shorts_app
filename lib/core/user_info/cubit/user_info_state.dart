part of 'user_info_cubit.dart';

class UserInfoState {}

class GetUserInfoLoadingState extends UserInfoState {}

class GetUserInfoSuccessState extends UserInfoState {
  final UserModel? userModel;

  GetUserInfoSuccessState({
    required this.userModel,
  });
}

class GetUserInfoErrorState extends UserInfoState {
  final String message;

  GetUserInfoErrorState({required this.message});
}

class InternetFailureState extends UserInfoState {
  final String message;

  InternetFailureState({required this.message});
}
