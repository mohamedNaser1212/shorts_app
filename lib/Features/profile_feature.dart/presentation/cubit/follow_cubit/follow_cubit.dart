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
  final Map<String, FollowModel> _followStatus = {};
  static FollowCubit get(context) => BlocProvider.of(context);

  Map<String, FollowModel> get followStatus => _followStatus;

  Future<void> followUser({
    required String currentUserId,
    required String targetUserId,
  }) async {
    emit(ToggleFollowLoadingState());
    final result = await followUserUseCase.call(
      currentUserId: currentUserId,
      targetUserId: targetUserId,
    );
    result.fold((failure) {
      print('error cubit ${failure.message}');
      emit(ToggleFollowErrorState(message: failure.message));
    }, (followModel) {
      getFollowersCount(userId: targetUserId);

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
      // getFollowingsCount(userId: userId);
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
      print('followingsCount $followersCount');
      emit(FollowingCountSuccessState(count: followersCount));
    });
  }

  void updateFollowersCount({required bool isFollowing}) {
    followerCounts = isFollowing ? followerCounts + 1 : followerCounts - 1;
    emit(FollowersCountSuccessState(count: followerCounts));
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

  // void updateFollowersCount(
  //     {required String userId, required bool isFollowing}) {
  //   if (isFollowing) {
  //     followerCounts++;
  //   } else {
  //     followerCounts--;
  //   }
  //   emit(FollowersCountSuccessState(count: followerCounts));
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

  void reset() {
    _followStatus.clear();
    followingCounts = 0;
    followerCounts = 0;
    //   emit(FollowState());
  }
}
