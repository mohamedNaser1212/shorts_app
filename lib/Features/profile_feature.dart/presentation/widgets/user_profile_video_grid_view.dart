import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/profile_state.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_screen_body.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_video_grid_view_body.dart';
import 'package:shorts/core/functions/toast_function.dart';

import 'custom_shimmer_grid_view_Widget.dart';

class UserProfileVideosGridView extends StatefulWidget {
  const UserProfileVideosGridView({super.key, required this.state});

  final UserProfileScreenBodyState state;

  @override
  State<UserProfileVideosGridView> createState() =>
      _UserProfileVideosGridViewState();
}

class _UserProfileVideosGridViewState extends State<UserProfileVideosGridView> {
  final ScrollController _scrollController = ScrollController();
  final int _page = 0;
  bool allVideosLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_page == 0) {
      GetUserVideosCubit.get(context).videos = [];
      print('get user videos');
      GetUserVideosCubit.get(context).getUserVideos(
        userId: widget.state.widget.userEntity!.id!,
        page: _page + 1,
      );
    }

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!allVideosLoaded &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.7) {
      final cubit = GetUserVideosCubit.get(context);
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
                    if (index >= state.videos.length) {
                      return const SizedBox();
                    }
                    return _builder(index: index, successState: state);
                  },
                ),
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
