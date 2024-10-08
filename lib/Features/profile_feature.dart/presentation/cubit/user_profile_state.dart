part of 'user_profile_cubit.dart';

class UserProfileState {}

class GetUserVideosLoading extends UserProfileState {}

class GetUserVideosSuccessState extends UserProfileState {
  final List<VideoEntity> videos;

  GetUserVideosSuccessState({
    required this.videos,
  });
}

class GetUserVideosError extends UserProfileState {
  final String message;

  GetUserVideosError({
    required this.message,
  });
}
