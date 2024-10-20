import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/get_videos_use_case/get_videos_use_case.dart';
import '../../../domain/video_entity/video_entity.dart';
part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final GetVideosUseCase getVideosUseCase;

  VideoCubit({
    required this.getVideosUseCase,
  }) : super(VideoInitial());

  static VideoCubit get(context) => BlocProvider.of(context);
  List<VideoEntity> videos = [];


  
  Future<void> getVideos() async {
    emit(GetVideoLoading());
    final result = await getVideosUseCase.call();
    result.fold(
        (failure) => emit(VideoUploadErrorState(message: failure.message)),
        (videos) {
      this.videos = videos;
      print('Videos: ${videos.length}');

      emit(GetVideoSuccess(videos: videos));
    });
  }

  
}
