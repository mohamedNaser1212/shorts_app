import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/get_videos_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/videos_list.dart';

class VideosPageViewWidget extends StatefulWidget {
  final int? initialIndex;

  const VideosPageViewWidget({Key? key, this.initialIndex}) : super(key: key);

  @override
  State<VideosPageViewWidget> createState() => _VideosPageViewWidgetState();
}

class _VideosPageViewWidgetState extends State<VideosPageViewWidget> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex ?? 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoCubit, VideoState>(
      builder: (context, state) {
        if (state is GetVideoSuccess) {
          return PageView.builder(
            controller: _pageController,
            itemCount: state.videos.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final video = state.videos[index];
              final isShared = video.sharedBy != null;
              CommentsCubit.get(context).getComments(videoId: video.id);

              return VideoListItem(
                videoEntity: video,
                userModel: video.user,
                isShared: isShared,
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
