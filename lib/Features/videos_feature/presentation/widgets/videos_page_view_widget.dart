import 'package:flutter/material.dart';
import 'package:shorts/Features/favourites_feature/domain/favourite_entitiy.dart';
import 'package:shorts/Features/videos_feature/presentation/screens/videos_list.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';

class VideosPageViewWidget extends StatelessWidget {
  const VideosPageViewWidget({
    super.key, required this.state,
  });
  final GetVideoSuccess state ;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: state.videos.length,
      itemBuilder: (context, index) {
        final video = state.videos[index];
    
        return VideoListItem(
          videoEntity: video,
          userModel: video.user,
          favouriteEntity: FavouritesEntity(
            id: video.id,
            videoUrl: video.videoUrl,
            user: video.user,
            thumbnail: '',
          ),
        );
      },
    );
  }
}
