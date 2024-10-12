import 'package:bloc/bloc.dart';
import 'package:shorts/Features/profile_feature.dart/domain/use_case/user_profile_videos_use_case.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit({
    required this.getUserInfoUseCase,
  }) : super(UserProfileState());

  final List<VideoEntity> videos = [];

  final UserProfileVideosUseCase getUserInfoUseCase;

  Future<void> getUserVideos({
    required String userId,
  }) async {
    emit(GetUserVideosLoading());
    final result = await getUserInfoUseCase.call(userId: userId);
    result.fold(
      (failure) => emit(GetUserVideosError(message: failure.message)),
      (videos) {
        this.videos.addAll(videos);
        emit(GetUserVideosSuccessState(videos: this.videos));
      }
    );
  }
}
