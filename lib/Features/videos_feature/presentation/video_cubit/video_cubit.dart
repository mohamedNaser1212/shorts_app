import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/get_videos_use_case/get_videos_use_case.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/upload_video_use_case/upload_video_use_case.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit({
    required this.uploadVideoUseCase,
    required this.getVideosUseCase,
  }) : super(VideoInitial());

  static VideoCubit get(context) => BlocProvider.of(context);

  final UploadVideoUseCase uploadVideoUseCase;
  final GetVideosUseCase getVideosUseCase;

  Future<void> uploadVideo() async {
    emit(VideoUploading());
    final result = await uploadVideoUseCase();
    result.fold(
      (failure) => emit(VideoError(message: failure.message)),
      (video) => emit(VideoUploaded(videoUrl: video.videoUrl)),
    );
  }

  Future<void> getVideos() async {
    emit(GetVideoLoading());
    final result = await getVideosUseCase();
    result.fold(
      (failure) => emit(VideoError(message: failure.message)),
      (videos) => emit(GetVideoSuccess(videos: videos)),
    );
  }
}
