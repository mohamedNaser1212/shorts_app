import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/get_videos_use_case/get_videos_use_case.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/upload_video_use_case/upload_video_use_case.dart';
import '../../domain/video_entity/video_entity.dart';
part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final UploadVideoUseCase uploadVideoUseCase;
  final GetVideosUseCase getVideosUseCase;

  VideoCubit({
    required this.uploadVideoUseCase,
    required this.getVideosUseCase,
  }) : super(VideoInitial());

  static VideoCubit get(context) => BlocProvider.of(context);
  List<VideoEntity> videos = [];

  Future<String?> pickVideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null && result.files.isNotEmpty) {
      final path = result.files.single.path;
      print('Picked file path: $path');
      return path;
    }
    return null;
  }

Future<void> uploadVideo({
  required VideoModel videoModel
}) async {
  emit(VideoUploadLoadingState());

  final result = await uploadVideoUseCase.call(
   videoModel: videoModel
  );

  result.fold(
    (failure) {
      print('Error uploading video: ${failure.message}');
      emit(VideoUploadErrorState(message: failure.message));
    },
    (video) => emit(VideoUploadedSuccessState(videoUrl: video.videoUrl)),
  );
}


  void selectVideo(String videoPath) {
    emit(VideoUploadedSuccessState(videoUrl: videoPath));
  }

  Future<void> getVideos() async {
    emit(GetVideoLoading());
    final result = await getVideosUseCase.call();
    result.fold(
        (failure) => emit(VideoUploadErrorState(message: failure.message)),
        (videos) {
      this.videos = videos;

      emit(GetVideoSuccess(videos: videos));
    });
  }
}
