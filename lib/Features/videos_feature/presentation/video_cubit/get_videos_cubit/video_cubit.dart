import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/get_videos_use_case/get_videos_use_case.dart';

import '../../../domain/video_entity/video_entity.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final GetVideosUseCase getVideosUseCase;
  List<VideoEntity> videos = [];
  int _currentPage = 0; // Start with the first page

  bool _isLoadingMore = false;
  static const int pageSize = 2; // Load 2 videos at a time

  VideoCubit({required this.getVideosUseCase}) : super(VideoInitial());

  static VideoCubit get(context) => BlocProvider.of(context);

  Future<void> getVideos({required int page}) async {
    if (_isLoadingMore) return; // Prevent multiple simultaneous loads
    _isLoadingMore = true;

    final result = await getVideosUseCase.call(page: page);
    result.fold(
      (failure) {
        emit(VideoUploadErrorState(message: failure.message));
      },
      (fetchedVideos) {
        if (page == 0) videos.clear(); // Clear only on the first load

        videos.addAll(fetchedVideos);
        print('Loaded ${videos.length} videos');
        emit(GetVideoSuccess(videos: List.of(videos))); // Emit new list
      },
    );

    _isLoadingMore = false;
  }

  Future<void> loadMoreVideos() async {
    if (!_isLoadingMore) {
      _currentPage++;
      await getVideos(page: _currentPage);
    }
  }

  void reset() {
    videos.clear();
    _currentPage = 0; // Reset to the first page
    _isLoadingMore = true; // Allow loading of more videos again
  }
}
