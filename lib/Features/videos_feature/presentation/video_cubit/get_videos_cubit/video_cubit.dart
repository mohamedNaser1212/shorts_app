import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/get_videos_use_case/get_videos_use_case.dart';
import '../../../domain/video_entity/video_entity.dart';
part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final GetVideosUseCase getVideosUseCase;
  List<VideoEntity> videos = [];
  int _currentPage = 0;
  // bool _isFetchingMore = false;

  VideoCubit({required this.getVideosUseCase}) : super(VideoInitial());

  static VideoCubit get(context) => BlocProvider.of(context);

  Future<void> getVideos() async {
 //   emit(GetVideoLoading());  // Emit loading state when fetching videos
    final result = await getVideosUseCase.call(page: _currentPage);
    result.fold(
      (failure) {
        emit(VideoUploadErrorState(message: failure.message));
      //  _isFetchingMore = false;
      },
      (fetchedVideos) {
        videos.addAll(fetchedVideos);
        emit(GetVideoSuccess(videos: videos));
      //  _isFetchingMore = false;  // Reset fetching flag
      },
    );
  }

  // Uncomment this if you want to implement load more functionality
  // Future<void> loadMoreVideos() async {
  //   if (_isFetchingMore) return;
  //   _isFetchingMore = true;
  //   _currentPage++;
  //   await getVideos(); // Fetch more videos
  // }
}
