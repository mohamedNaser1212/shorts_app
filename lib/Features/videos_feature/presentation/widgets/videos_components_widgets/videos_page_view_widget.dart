import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';

import 'package:shorts/Features/videos_feature/presentation/video_cubit/get_videos_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/videos_list.dart';
import 'package:shorts/core/widgets/custom_title.dart';

// ignore: must_be_immutable
class VideosPageViewWidget extends StatelessWidget {
  VideosPageViewWidget({
    super.key,
    required this.state,
    this.initialIndex,
  });

  final GetVideoSuccess state;
  int? initialIndex;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: state.videos.length,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: PageController(initialPage: initialIndex ?? 0),
      itemBuilder: (context, index) {
        final video = state.videos[index];
        final isShared = video.sharedBy != null;
        CommentsCubit.get(context).getComments(videoId: video.id);
        return Column(
          children: [
            if (isShared)
              CustomTitle(
                title: 'Shared by: ${video.sharedBy?.name}',
                style: TitleStyle.style20,
                color: Colors.white,
              ),
            Expanded(
              child: VideoListItem(
                videoEntity: video,
                userModel: video.user,
              ),
            ),
          ],
        );
      },
    );
  }
}
