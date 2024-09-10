part of 'video_cubit.dart';

abstract class VideoState {}

class VideoInitial extends VideoState {}

class VideoUploading extends VideoState {}

class VideoUploaded extends VideoState {
  final String videoUrl;

  VideoUploaded({required this.videoUrl});
}

class VideoError extends VideoState {
  final String message;
  VideoError({
    required this.message,
  });
}

class GetVideoLoading extends VideoState {}

class GetVideoSuccess extends VideoState {
  final List<VideoEntity> videos;

  GetVideoSuccess({required this.videos});
}

class GetVideosError extends VideoState {
  final String message;
  GetVideosError({
    required this.message,
  });
}
