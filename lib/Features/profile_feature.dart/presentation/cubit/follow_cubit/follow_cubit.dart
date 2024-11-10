import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/follow_model.dart';
import '../../../domain/use_case/check_user_follow.dart';
import '../../../domain/use_case/follow_use_case.dart';
import '../../../domain/use_case/get_followers_count_use_case.dart';
import '../../../domain/use_case/get_followings_count_use_case.dart';

part 'follow_state.dart';

class FollowCubit extends Cubit<FollowState> {
  FollowCubit({
    required this.followUserUseCase,
    // required this.unfollowUserUseCase,
    required this.getFollowersCountUseCase,
    required this.getFollowingCountUseCase,
    required this.isUserFollowedUseCase,
  }) : super(FollowState());
  final ToggleFollowUserUseCase followUserUseCase;
  // final UnfollowUserUseCase unfollowUserUseCase;
  final GetFollowersCountUseCase getFollowersCountUseCase;
  final GetFollowingCountUseCase getFollowingCountUseCase;
  final IsUserFollowedUseCase isUserFollowedUseCase;
  // Store follow status for each user in a map
  final Map<String, FollowModel> _followStatus = {};
  static FollowCubit of(context) {
    return BlocProvider.of<FollowCubit>(context);
  }

  // Getter to access follow status map
  Map<String, FollowModel> get followStatus => _followStatus;

  Future<void> followUser({
    required String currentUserId,
    required String targetUserId,
    required String targetUserName,
  }) async {
    emit(ToggleFollowLoadingState());
    final result = await followUserUseCase.call(
      currentUserId: currentUserId,
      targetUserId: targetUserId,
      targetUserName: targetUserName,
    );
    result.fold((failure) {
      emit(ToggleFollowErrorState(message: failure.message));
    }, (followModel) {
      emit(ToggleFollowSuccessState());
    });
  }

  int followerCounts = 0;
  Future<void> getFollowersCount({
    required String userId,
  }) async {
    emit(FollowersCountLoading());
    final result = await getFollowersCountUseCase.call(userId: userId);
    result.fold((failure) {
      emit(FollowersCountErrorState(message: failure.message));
    }, (followersCount) {
      followerCounts = followersCount;
      print('followersCount $followersCount');
      getFollowingsCount(userId: userId);
      emit(FollowersCountSuccessState(count: followersCount));
    });
  }

  int followingCounts = 0;
  Future<void> getFollowingsCount({
    required String userId,
  }) async {
    emit(FollowingCountLoadingState());
    final result = await getFollowingCountUseCase.call(userId: userId);
    result.fold((failure) {
      emit(FollowingCountErrorState(message: failure.message));
    }, (followersCount) {
      followingCounts = followersCount;
      print('followersCount $followersCount');
      emit(FollowingCountSuccessState(count: followersCount));
    });
  }

  // Future<void> unfollowUser({
  //   required String currentUserId,
  //   required String targetUserId,
  // }) async {
  //   emit(UserActionLoading());
  //   final result = await unfollowUserUseCase.call(
  //       currentUserId: currentUserId, targetUserId: targetUserId);
  //   result.fold((failure) {
  //     emit(UnfollowUserErrorState(message: failure.message));
  //   }, (followModel) {
  //     _followStatus[targetUserId] = followModel;
  //     emit(UserUnfollowedSuccessState(followModel: followModel));
  //   });
  // }

  Future<bool> isUserFollowed({
    required String currentUserId,
    required String targetUserId,
  }) async {
    emit(ToggleFollowLoadingState());
    final result = await isUserFollowedUseCase.isUserFollowed(
        currentUserId: currentUserId, targetUserId: targetUserId);
    result.fold((failure) {
      emit(UserActionErrorState(message: failure.message));
    }, (isFollowing) {
      // _followStatus[targetUserId] = FollowModel(
      //   targetUserId: targetUserId,
      //   targetUserName: '',
      //   isFollowing: isFollowing,
      // );.
      print('isFollowing cubbit $isFollowing');
      emit(UserActionSuccessState(isFollowing: isFollowing));
      return isFollowing;
    });
    return false;
  }
}
