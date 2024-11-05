import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/get_videos_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/videos_list.dart';

import '../../../../profile_feature.dart/presentation/widgets/user_profile_video_grid_view_body.dart';

class VideosPageViewWidget extends StatefulWidget {
  final UserProfileVideosGridViewBodyState? userProfileVideosGridViewBodyState;

  const VideosPageViewWidget(
      {super.key, this.userProfileVideosGridViewBodyState});

  @override
  State<VideosPageViewWidget> createState() => _VideosPageViewWidgetState();
}

class _VideosPageViewWidgetState extends State<VideosPageViewWidget> {
  late PageController _pageController;
  final int pageSize = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.userProfileVideosGridViewBodyState?.widget.index ?? 0,
    );
    _pageController.addListener(_onPageChanged);

    context.read<VideoCubit>().getVideos(page: pageSize + 1);
  }

  void _onPageChanged() {
    final cubit = context.read<VideoCubit>();

    if (_pageController.page?.toInt() == cubit.videos.length - 1) {
      cubit.loadMoreVideos();
    }
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
        if (state is VideoUploadErrorState) {
          return Center(child: Text('Error: ${state.message}'));
        }
        if (state is GetVideoSuccess) {
          final videos = state.videos;

          return PageView.builder(
            controller: _pageController,
            itemCount: videos.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final video = videos[index];
              final isShared = video.sharedBy != null;
            
              CommentsCubit.get(context).getCommentsCount(
                videoId: video.id,
              );
              // CommentsCubit.get(context)
              //     .getComments(videoId: video.id, page: 0);
            
              return VideoListItem(
                videoEntity: video,
                isShared: isShared,
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
