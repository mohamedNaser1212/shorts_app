import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/get_videos_use_case/get_videos_use_case.dart';

import '../../../domain/video_entity/video_entity.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final GetVideosUseCase getVideosUseCase;
  List<VideoEntity> videos = [];
  num _currentPage = 0; // Start with the first page

  bool isLoadingMore = false;
  static const num pageSize = 2; // Load 2 videos at a time

  VideoCubit({required this.getVideosUseCase}) : super(VideoInitial());

  static VideoCubit get(context) => BlocProvider.of(context);

  Future<void> getVideos({required num page}) async {
    if (isLoadingMore) return;
    isLoadingMore = true;

    final result = await getVideosUseCase.call(page: page);
    result.fold(
      (failure) {
        emit(VideoUploadErrorState(message: failure.message));
      },
      (fetchedVideos) {
        if (page == 0) videos.clear();

        videos.addAll(fetchedVideos);
        print('Loaded ${videos.length} videos');
        emit(GetVideoSuccess(videos: List.of(videos)));
      },
    );

    isLoadingMore = false;
  }

  Future<void> loadMoreVideos() async {
    if (!isLoadingMore) {
      _currentPage++;
      await getVideos(page: _currentPage);
    }
  }

  void reset() {
    videos.clear();
    _currentPage = 0;
    isLoadingMore = true;
  }
}
