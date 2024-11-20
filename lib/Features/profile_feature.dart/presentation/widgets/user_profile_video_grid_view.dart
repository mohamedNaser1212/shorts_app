import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/profile_state.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_screen_body.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_video_grid_view_body.dart';
import 'package:shorts/core/functions/toast_function.dart';

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
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final cubit = GetUserVideosCubit.get(context);

    if (cubit.currentUserId != widget.state.widget.userEntity!.id) {
      cubit.reset();
      cubit.getUserVideos(
        userId: widget.state.widget.userEntity!.id!,
        page: 1,
      );
    }

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final cubit = GetUserVideosCubit.get(context);
    if (!cubit.isLoadingMore &&
        cubit.hasMoreVideos &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.7) {
      cubit.loadMoreVideos(userId: widget.state.widget.userEntity!.id!);
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
          if (state.videos.isEmpty) {
            return const Center(
                child: CustomTitle(
              title: 'No videos found',
              style: TitleStyle.styleBold20,
            ));
          }
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
          }
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _builder(
      {required int index, required GetUserVideosSuccessState successState}) {
    final video = successState.videos[index];
    return UserProfileVideosGridViewBody(
      video: video,
      videos: [video],
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
