import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/get_videos_use_case/get_videos_use_case.dart';

import '../../../domain/video_entity/video_entity.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final GetVideosUseCase getVideosUseCase;
  List<VideoEntity> videos = [];

  bool isLoadingMore = false;

  VideoCubit({required this.getVideosUseCase}) : super(VideoInitial());

  static VideoCubit get(context) => BlocProvider.of(context);

  Future<void> getVideos() async {
    emit(GetVideoLoading());
    if (isLoadingMore) return;
    isLoadingMore = true;

    final result = await getVideosUseCase.call();
    result.fold(
      (failure) {
        emit(VideoUploadErrorState(message: failure.message));
      },
      (fetchedVideos) {
        videos.addAll(fetchedVideos);
        isLoadingMore = fetchedVideos.length == 6;
        print('Loaded ${videos.length} videos');
        emit(
          GetVideoSuccess(
            videos: List.from(videos),
          ),
        );
      },
    );

    isLoadingMore = false;
  }

  Future<void> loadMoreVideos() async {
    if (!isLoadingMore) return;
    await getVideos();
  }

  void reset() {
    videos = [];
    isLoadingMore = true;
    emit(GetVideoLoading());
  }
}
