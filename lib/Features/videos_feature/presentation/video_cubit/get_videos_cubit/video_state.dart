part of 'video_cubit.dart';

abstract class VideoState {}

class VideoInitial extends VideoState {}


class GetVideoLoading extends VideoState {}

class GetVideoSuccess extends VideoState {
  final List<VideoEntity> videos;

  GetVideoSuccess({required this.videos});
}
class VideoUploadErrorState extends VideoState {
  final String message;

  VideoUploadErrorState({required this.message});
}

class GetVideosError extends VideoState {
  final String message;

  GetVideosError({required this.message});
}

class VideoSelected extends VideoState {
  final String videoPath;

  VideoSelected({required this.videoPath});
}

