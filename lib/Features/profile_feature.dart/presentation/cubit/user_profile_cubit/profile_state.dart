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

// New states for following and unfollowing actions
class UserActionLoading extends UserProfileState {}

class UserFollowedSuccessState extends UserProfileState {}

class UserUnfollowedSuccessState extends UserProfileState {}

class UnfollowUserErrorState extends UserProfileState {
  final String message;

  UnfollowUserErrorState({
    required this.message,
  });
}

// New states for fetching follower and following counts
class FollowersCountLoading extends UserProfileState {}

class FollowersCountSuccessState extends UserProfileState {
  final int count;

  FollowersCountSuccessState({
    required this.count,
  });
}

class FollowersCountErrorState extends UserProfileState {
  final String message;

  FollowersCountErrorState({
    required this.message,
  });
}

class FollowingCountLoadingState extends UserProfileState {}

class FollowingCountSuccessState extends UserProfileState {
  final int count;

  FollowingCountSuccessState({
    required this.count,
  });
}

class FollowingCountErrorState extends UserProfileState {
  final String message;

  FollowingCountErrorState({
    required this.message,
  });
}
