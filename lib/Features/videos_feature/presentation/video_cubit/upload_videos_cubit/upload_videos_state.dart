part of 'upload_videos_cubit.dart';

 class UploadVideosState {}
class VideoUploadLoadingState extends UploadVideosState {}

class VideoUploadedSuccessState extends UploadVideosState {
  final String videoUrl;

  VideoUploadedSuccessState({required this.videoUrl});
}

class VideoUploadErrorState extends UploadVideosState {
  final String message;

  VideoUploadErrorState({required this.message});
}

class VideoPickedLoading extends UploadVideosState {}

class VideoPickedSuccess extends UploadVideosState {
  final File file ;

  VideoPickedSuccess({required this.file});
}

class VideoPickedError extends UploadVideosState {
  final String message;

  VideoPickedError({required this.message});
}
class ShareVideoLoadingState extends UploadVideosState {}

class ShareVideoSuccessState extends UploadVideosState {

}

class ShareVideoErrorState extends UploadVideosState {
  final String message;

  ShareVideoErrorState({required this.message});
}
