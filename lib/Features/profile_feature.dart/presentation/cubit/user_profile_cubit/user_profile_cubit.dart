import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/domain/use_case/user_profile_videos_use_case.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/profile_state.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';

class GetUserVideosCubit extends Cubit<UserProfileState> {
  final UserProfileVideosUseCase getUserInfoUseCase;
  List<VideoEntity> videos = [];
  num _currentPage = 1;
  String? currentUserId;

  bool isLoadingMore = false;
  bool hasMoreVideos = true;

  static const int pageSize = 6;

  GetUserVideosCubit({required this.getUserInfoUseCase})
      : super(GetUserVideosLoading());

  static GetUserVideosCubit get(context) => BlocProvider.of(context);

  Future<void> getUserVideos({
    required String userId,
    required num page,
    bool isInitialLoad = false,
  }) async {
    if (isLoadingMore) return;

    if (isInitialLoad || currentUserId != userId) {
      reset();
      currentUserId = userId;
      emit(GetUserVideosLoading());
    }

    isLoadingMore = true;
    final result = await getUserInfoUseCase.call(
      userId: userId,
      pageSize: pageSize,
    );

    result.fold(
      (failure) {
        emit(GetUserVideosError(message: failure.message));
      },
      (fetchedVideos) {
        videos.addAll(fetchedVideos);
        hasMoreVideos = fetchedVideos.length == pageSize;
        emit(GetUserVideosSuccessState(
          videos: List.from(videos),
          hasMoreVideos: hasMoreVideos,
        ));
      },
    );

    isLoadingMore = false;
  }

  Future<void> loadMoreVideos({required String userId}) async {
    if (!hasMoreVideos) return;

    _currentPage++;
    await getUserVideos(userId: userId, page: _currentPage);
  }

  void reset() {
    videos.clear();
    _currentPage = 1;
    isLoadingMore = false;
    hasMoreVideos = true;
    emit(GetUserVideosLoading());
  }
}
