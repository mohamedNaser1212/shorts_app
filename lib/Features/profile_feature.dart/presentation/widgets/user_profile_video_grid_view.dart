import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/profile_state.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_screen_body.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_video_grid_view_body.dart';
import 'package:shorts/core/functions/toast_function.dart';
import 'package:shorts/core/widgets/custom_title.dart';

import '../../../../core/managers/styles_manager/color_manager.dart';
import 'custom_shimmer_grid_view_Widget.dart';

class UserProfileVideosGridView extends StatefulWidget {
  const UserProfileVideosGridView({super.key, required this.state});

  final UserProfileScreenBodyState state;

  @override
  State<UserProfileVideosGridView> createState() =>
      _UserProfileVideosGridViewState();
}

class _UserProfileVideosGridViewState extends State<UserProfileVideosGridView> {
  ScrollController _scrollController = ScrollController();
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<GetUserVideosCubit>().getUserVideos(
          userId: widget.state.widget.userEntity!.id!,
          page: _page + 1,
        );
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final cubit = context.read<GetUserVideosCubit>();
      if (!cubit.isLoadingMore && cubit.hasMoreVideos) {
        cubit.loadMoreVideos(userId: widget.state.widget.userEntity!.id!);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserVideosCubit, UserProfileState>(
      builder: (context, state) {
        if (state is GetUserVideosLoading) {
          return const CustomShimmerGridViewWidget();
        } else if (state is GetUserVideosError) {
          ToastHelper.showToast(message: state.message);
          return const Center(child: Text('Error loading videos'));
        } else if (state is GetUserVideosSuccessState) {
          if (state.videos.isNotEmpty) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: _gridDelegate(),
                  itemCount:
                      state.videos.length + (state.hasMoreVideos ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.videos.length && state.hasMoreVideos) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return _builder(index: index, successState: state);
                  },
                ),
              ),
            );
          } else {
            return const Center(
              child: CustomTitle(
                title: 'There are no videos yet',
                style: TitleStyle.styleBold18,
                color: ColorController.whiteColor,
              ),
            );
          }
        }
        return const Center(child: Text('No videos found'));
      },
    );
  }

  Widget _builder(
      {required int index, required GetUserVideosSuccessState successState}) {
    final video = successState.videos[index];
    return UserProfileVideosGridViewBody(
      video: video,
      videos: [successState.videos[index]],
      index: index,
    );
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
