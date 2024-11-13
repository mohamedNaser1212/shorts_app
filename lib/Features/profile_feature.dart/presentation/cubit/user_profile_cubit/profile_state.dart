import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';

class UserProfileState {}

class GetUserVideosLoading extends UserProfileState {}

class GetUserVideosSuccessState extends UserProfileState {
  final List<VideoEntity> videos;
  final bool hasMoreVideos;

  GetUserVideosSuccessState({
    required this.videos,
    required this.hasMoreVideos,
  });
}

class GetUserVideosError extends UserProfileState {
  final String message;

  GetUserVideosError({
    required this.message,
  });
}
