part of 'video_cubit.dart';

abstract class VideoState {}

class VideoInitial extends VideoState {}

class VideoUploadLoadingState extends VideoState {}

class VideoUploadedSuccessState extends VideoState {
  final String videoUrl;

  VideoUploadedSuccessState({required this.videoUrl});
}

class VideoUploadErrorState extends VideoState {
  final String message;

  VideoUploadErrorState({required this.message});
}

class GetVideoLoading extends VideoState {}

class GetVideoSuccess extends VideoState {
  final List<VideoEntity> videos;

  GetVideoSuccess({required this.videos});
}

class GetVideosError extends VideoState {
  final String message;

  GetVideosError({required this.message});
}

class VideoSelected extends VideoState {
  final String videoPath;

  VideoSelected({required this.videoPath});
}

class VideoPickedLoading extends VideoState {}

class VideoPickedSuccess extends VideoState {
  final File file ;

  VideoPickedSuccess({required this.file});
}

class VideoPickedError extends VideoState {
  final String message;

  VideoPickedError({required this.message});
}
