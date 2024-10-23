import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';

import 'package:shorts/Features/videos_feature/presentation/video_cubit/get_videos_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/videos_list.dart';

// ignore: must_be_immutable
class VideosPageViewWidget extends StatelessWidget {
  VideosPageViewWidget({
    super.key,
    this.initialIndex,
  });

  int? initialIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoCubit, VideoState>(
      builder: (context, state) {
        // if (state is SubjectFailed) {
        //   return ErrorOutput(message: state.message);
        // }
        if (state is GetVideoSuccess) {
          return PageView.builder(
            itemCount: state.videos.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            controller: PageController(initialPage: initialIndex ?? 0),
            itemBuilder: (context, index) {
              final video = state.videos[index];
              final isShared = video.sharedBy != null;
              CommentsCubit.get(context).getComments(videoId: video.id);
              return Expanded(
                child: VideoListItem(
                  videoEntity: video,
                  userModel: video.user,
                  isShared: isShared,
                ),
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
