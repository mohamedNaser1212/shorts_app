part of 'update_user_data_cubit.dart';

class UpdateUserDataState {}

class UpdateUserDataLoadingState extends UpdateUserDataState {}

class UpdateUserDataSuccessState extends UpdateUserDataState {
    final UserEntity? userEntity;

  UpdateUserDataSuccessState({required this.userEntity});
}

class UpdateUserDataErrorState extends UpdateUserDataState {
  final String message;

  UpdateUserDataErrorState({required this.message});
}
