import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/get_videos_use_case/get_videos_use_case.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/upload_video_use_case/upload_video_use_case.dart';

import '../../../authentication_feature/data/user_model/user_model.dart';
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
    required String videoPath,
    required String description,
    required UserModel user,
  }) async {
    emit(VideoUploading());

    final result = await uploadVideoUseCase.call(
      description: description,
      videoPath: videoPath,
      user: user,
    );
    result.fold(
      (failure) {
        print('Error uploading video: ${failure.message}');
        emit(VideoError(message: failure.message));
      },
      (video) => emit(VideoUploaded(videoUrl: video.videoUrl)),
    );
  }

  Future<void> getVideos() async {
    emit(GetVideoLoading());
    final result = await getVideosUseCase.call();
    result.fold((failure) => emit(VideoError(message: failure.message)),
        (videos) {
      this.videos = videos;

      emit(GetVideoSuccess(videos: videos));
    });
  }
}
