part of 'upload_videos_cubit.dart';

class UploadVideosState {}

class VideoUploadLoadingState extends UploadVideosState {}

class VideoUploadedSuccessState extends UploadVideosState {
  final VideoEntity videoEntity;

  VideoUploadedSuccessState({required this.videoEntity});
}

class VideoUploadErrorState extends UploadVideosState {
  final String message;

  VideoUploadErrorState({required this.message});
}

class VideoPickedLoading extends UploadVideosState {}

class VideoPickedSuccess extends UploadVideosState {
  final File file;

  VideoPickedSuccess({required this.file});
}

class VideoPickedError extends UploadVideosState {
  final String message;

  VideoPickedError({required this.message});
}
