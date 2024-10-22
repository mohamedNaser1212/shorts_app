


import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';

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
