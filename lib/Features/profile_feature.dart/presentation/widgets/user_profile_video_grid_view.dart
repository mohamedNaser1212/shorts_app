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
  const UserProfileVideosGridView({
    super.key,
    required this.state,
  });
  final UserProfileScreenBodyState state;

  @override
  State<UserProfileVideosGridView> createState() =>
      _UserProfileVideosGridViewState();
}

class _UserProfileVideosGridViewState extends State<UserProfileVideosGridView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserVideosCubit, UserProfileState>(
      listener: (context, state) {
        if (state is GetUserVideosError) {
          ToastHelper.showToast(message: state.message);
        }
      },
      builder: (context, state) {
        if (state is GetUserVideosLoading) {
          return const CustomShimmerGridViewWidget();
        } else if (state is GetUserVideosSuccessState) {
          if (state.videos.isNotEmpty) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: _gridDelegate(),
                  itemCount: state.videos.length,
                  itemBuilder: (context, index) {
                    print('index: $index');
                    return _builder(
                      index: index,
                      successState: state,
                      state: state,
                    );
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
}

Widget _builder({
  required UserProfileState state,
  required int index,
  required GetUserVideosSuccessState successState,
}) {
  final video = successState.videos[index];
  print('VIDEOEntity: ${video.thumbnail}');

  return UserProfileVideosGridViewBody(
    video: video,
    videos: [successState.videos[index]],
    index: index,
  );
}

SliverGridDelegateWithFixedCrossAxisCount _gridDelegate() {
  return const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.75,
    crossAxisSpacing: 2.0,
    mainAxisSpacing: 5.0,
  );
}
