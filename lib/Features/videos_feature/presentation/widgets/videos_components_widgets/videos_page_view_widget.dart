import 'package:flutter/material.dart';

import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/videos_list.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';

class VideosPageViewWidget extends StatelessWidget {
  const VideosPageViewWidget({
    super.key,
    required this.state,
  });
  final GetVideoSuccess state;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: state.videos.length,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final video = state.videos[index];
        return VideoListItem(
          videoEntity: video,
          userModel: video.user,
        );
      },
    );
  }
}
