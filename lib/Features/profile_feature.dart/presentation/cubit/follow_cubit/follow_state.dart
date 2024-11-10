part of 'follow_cubit.dart';

class FollowState {}

// New states for following and unfollowing actions
class ToggleFollowLoadingState extends FollowState {}

class ToggleFollowSuccessState extends FollowState {
  //final FollowModel followModel;

  // ToggleFollowSuccessState({
  // //  required this.followModel,
  // });
}

class UserUnfollowedSuccessState extends FollowState {
  final FollowModel followModel;

  UserUnfollowedSuccessState({
    required this.followModel,
  });
}

class ToggleFollowErrorState extends FollowState {
  final String message;

  ToggleFollowErrorState({
    required this.message,
  });
}

// New states for fetching follower and following counts
class FollowersCountLoading extends FollowState {}

class FollowersCountSuccessState extends FollowState {
  final int count;

  FollowersCountSuccessState({
    required this.count,
  });
}

class FollowersCountErrorState extends FollowState {
  final String message;

  FollowersCountErrorState({
    required this.message,
  });
}

class FollowingCountLoadingState extends FollowState {}

class FollowingCountSuccessState extends FollowState {
  final int count;

  FollowingCountSuccessState({
    required this.count,
  });
}

class FollowingCountErrorState extends FollowState {
  final String message;

  FollowingCountErrorState({
    required this.message,
  });
}

// New state for checking if user is followed
class UserActionSuccessState extends FollowState {
  final bool isFollowing;

  UserActionSuccessState({
    required this.isFollowing,
  });
}

class UserActionErrorState extends FollowState {
  final String message;

  UserActionErrorState({
    required this.message,
  });
}
