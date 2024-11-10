import 'package:bloc/bloc.dart';
import 'package:shorts/Features/profile_feature.dart/domain/use_case/get_followers_count_use_case.dart';
import 'package:shorts/Features/profile_feature.dart/domain/use_case/user_profile_videos_use_case.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/profile_state.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';

import '../../../domain/use_case/follow_use_case.dart';
import '../../../domain/use_case/get_followings_count_use_case.dart';
import '../../../domain/use_case/unfollow_use_case.dart';

class GetUserVideosCubit extends Cubit<UserProfileState> {
  GetUserVideosCubit({
    required this.getUserInfoUseCase,
    required this.followUserUseCase,
    required this.unfollowUserUseCase,
    required this.getFollowersCountUseCase,
    required this.getFollowingCountUseCase,
  }) : super(UserProfileState());

  final List<VideoEntity> videos = [];
  final UserProfileVideosUseCase getUserInfoUseCase;
  final FollowUserUseCase followUserUseCase;
  final UnfollowUserUseCase unfollowUserUseCase;
  final GetFollowersCountUseCase getFollowersCountUseCase;
  final GetFollowingCountUseCase getFollowingCountUseCase;

  Future<void> getUserVideos({required String userId}) async {
    emit(GetUserVideosLoading());
    final result = await getUserInfoUseCase.call(userId: userId);
    result.fold((failure) {
      emit(GetUserVideosError(message: failure.message));
    }, (videos) {
      this.videos.addAll(videos);
      emit(GetUserVideosSuccessState(videos: this.videos));
    });
  }

  Future<void> followUser(
      {required String currentUserId, required String targetUserId}) async {
    emit(UserActionLoading());
    final result = await followUserUseCase.call(
        currentUserId: currentUserId, targetUserId: targetUserId);
    result.fold((failure) {
      emit(UnfollowUserErrorState(message: failure.message));
    }, (_) {
      emit(UserFollowedSuccessState());
    });
  }

  Future<void> unfollowUser(
      {required String currentUserId, required String targetUserId}) async {
    emit(UserActionLoading());
    final result = await unfollowUserUseCase.call(
        currentUserId: currentUserId, targetUserId: targetUserId);
    result.fold((failure) {
      emit(UnfollowUserErrorState(message: failure.message));
    }, (_) {
      emit(UserUnfollowedSuccessState());
    });
  }

  Future<void> getFollowersCount({required String userId}) async {
    emit(FollowersCountLoading());
    final result = await getFollowersCountUseCase.call(userId: userId);
    result.fold((failure) {
      emit(FollowersCountErrorState(message: failure.message));
    }, (count) {
      emit(FollowersCountSuccessState(count: count));
    });
  }

  Future<void> getFollowingCount({required String userId}) async {
    emit(FollowingCountLoadingState());
    final result = await getFollowingCountUseCase.call(userId: userId);
    result.fold((failure) {
      emit(FollowingCountErrorState(message: failure.message));
    }, (count) {
      emit(FollowingCountSuccessState(count: count));
    });
  }
}
