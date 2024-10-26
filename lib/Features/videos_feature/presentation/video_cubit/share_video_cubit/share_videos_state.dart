part of 'share_videos_cubit.dart';

 class ShareVideosState {}

class ShareVideoLoadingState extends ShareVideosState {}

class ShareVideoSuccessState extends ShareVideosState {

}

class ShareVideoErrorState extends ShareVideosState {
  final String message;

  ShareVideoErrorState({required this.message});
}
