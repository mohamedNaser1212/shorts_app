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
    required this.getFollowersCountUseCase,
    required this.getFollowingCountUseCase,
    required this.isUserFollowedUseCase,
  }) : super(FollowState());

  final ToggleFollowUserUseCase followUserUseCase;
  final GetFollowersCountUseCase getFollowersCountUseCase;
  final GetFollowingCountUseCase getFollowingCountUseCase;
  final IsUserFollowedUseCase isUserFollowedUseCase;

  final Map<String, int> _followersCounts = {};
  final Map<String, int> _followingsCounts = {};

  static FollowCubit get(context) => BlocProvider.of(context);

  Map<String, int> get followersCounts => _followersCounts;
  Map<String, int> get followingsCounts => _followingsCounts;

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
      emit(ToggleFollowErrorState(message: failure.message));
    }, (_) {
      getFollowersCount(userId: targetUserId);
      emit(ToggleFollowSuccessState());
    });
  }

  Future<void> getFollowersCount({required String userId}) async {
    emit(FollowersCountLoading());
    final result = await getFollowersCountUseCase.call(userId: userId);
    result.fold((failure) {
      emit(FollowersCountErrorState(message: failure.message));
    }, (followersCount) {
      _followersCounts[userId] = followersCount;
      emit(FollowersCountSuccessState(count: followersCount));
    });
  }

  Future<void> getFollowingsCount({required String userId}) async {
    emit(FollowingCountLoadingState());
    final result = await getFollowingCountUseCase.call(userId: userId);
    result.fold((failure) {
      emit(FollowingCountErrorState(message: failure.message));
    }, (followingsCount) {
      _followingsCounts[userId] = followingsCount;
      emit(FollowingCountSuccessState(count: followingsCount));
    });
  }

  int getFollowerCountForUser(String userId) {
    return _followersCounts[userId] ?? 0;
  }

  int getFollowingCountForUser(String userId) {
    return _followingsCounts[userId] ?? 0;
  }

  Future<void> isUserFollowed({
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
    });
  }

  void reset() {
    _followersCounts.clear();
    _followingsCounts.clear();
  }
}
