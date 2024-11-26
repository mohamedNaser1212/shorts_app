import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/profile_state.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_screen_body.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_video_grid_view_body.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';

import '../../../../core/widgets/custom_title.dart';
import 'custom_shimmer_grid_view_Widget.dart';

class UserProfileVideosGridView extends StatefulWidget {
  const UserProfileVideosGridView({super.key, required this.state});

  final UserProfileScreenBodyState state;

  @override
  State<UserProfileVideosGridView> createState() =>
      _UserProfileVideosGridViewState();
}

class _UserProfileVideosGridViewState extends State<UserProfileVideosGridView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserVideosCubit, UserProfileState>(
      builder: (context, state) {
        final cubit = GetUserVideosCubit.get(context);
        final videos = cubit.videos;

        if (state is GetUserVideosError) {
          return const Center(
            child: CustomTitle(
              title: 'Error loading videos',
              style: TitleStyle.styleBold20,
            ),
          );
        }

        if (videos.isEmpty && state is! GetUserVideosLoading) {
          return const Center(
            child: CustomTitle(
              title: 'No videos found',
              style: TitleStyle.styleBold20,
            ),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: _gridDelegate(),
          itemCount: videos.length + (cubit.hasMoreVideos ? 6 : 0),
          itemBuilder: (context, index) {
            if (index == videos.length && cubit.hasMoreVideos) {
              return _buildShimmerItem();
            }
            if (index < videos.length) {
              return _buildVideoItem(index, videos);
            }
            return _buildShimmerItem();
          },
        );
      },
    );
  }

  Widget _buildVideoItem(int index, List<VideoEntity> videos) {
    final video = videos[index];
    return UserProfileVideosGridViewBody(
      video: video,
      videos: videos,
      index: index,
    );
  }

  Widget _buildShimmerItem() {
    return CustomShimmerGridViewWidget();
  }

  SliverGridDelegateWithFixedCrossAxisCount _gridDelegate() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      childAspectRatio: 0.5,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
    );
  }
}
