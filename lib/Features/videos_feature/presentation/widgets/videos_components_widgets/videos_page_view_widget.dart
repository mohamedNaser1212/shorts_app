import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/get_favourites_cubit/favourites_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/get_videos_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/videos_list.dart';
import 'package:shorts/core/widgets/custom_title.dart';

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
  final num pageSize = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.userProfileVideosGridViewBodyState?.widget.index ?? 0,
    );
    _pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final cubit = VideoCubit.get(context);

    if (_pageController.page?.toInt() == cubit.videos.length - 2 &&
        !cubit.isLoadingMore) {
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
          return Center(
            child: CustomTitle(
              title: state.message,
              style: TitleStyle.styleBold20,
            ),
          );
        }
        if (state is GetVideoSuccess) {
          if (state.videos.isEmpty) {
            return const Center(
              child: CustomTitle(
                title: 'No Videos Yet',
                style: TitleStyle.styleBold20,
              ),
            );
          }
          final videos = state.videos;
          final isLoadingMore = VideoCubit.get(context).isLoadingMore;

          return PageView.builder(
            controller: _pageController,
            itemCount: videos.length + (isLoadingMore ? 1 : 0),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final video = videos[index];

              CommentsCubit.get(context).getCommentsCount(videoId: video.id);
              FavouritesCubit.get(context)
                  .getFavouritesCount(videoId: video.id);

              return VideoListItem(
                videoEntity: video,
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
