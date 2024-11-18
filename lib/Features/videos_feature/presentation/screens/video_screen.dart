import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_video_grid_view_body.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/get_videos_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/videos_page_view_widget.dart';
import 'package:shorts/core/functions/toast_function.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/widgets/custom_title.dart';

import '../../../../core/service_locator/service_locator.dart';
import '../../../favourites_feature/presentation/cubit/get_favourites_cubit/favourites_cubit.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key, this.userProfileVideosGridViewBody});

  final UserProfileVideosGridViewBodyState? userProfileVideosGridViewBody;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<VideoCubit>()
        ..getVideos(
          page: 0,
        ),
      child: Scaffold(
        appBar: AppBar(
          // title: const Text('Videos'),
          backgroundColor: ColorController.transparentColor,
        ),
        backgroundColor: ColorController.blackColor,
        body: BlocConsumer<UserInfoCubit, UserInfoState>(
          listener: _userInfoListener,
          builder: (context, userInfoState) {
            return BlocConsumer<FavouritesCubit, FavouritesState>(
              listener: _favouritesListener,
              builder: (context, favouritesState) {
                return BlocBuilder<VideoCubit, VideoState>(
                  //  listener: _videosListener,
                  builder: _videosBuilder,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _videosBuilder(BuildContext context, VideoState state) {
    if (state is GetVideoSuccess) {
      // CommentsCubit.get(context)
      //     .getCommentsCount(videoId: state.videos.first.id!);

      if (userProfileVideosGridViewBody != null) {
        return VideosPageViewWidget(
          userProfileVideosGridViewBodyState: userProfileVideosGridViewBody,
        );
      } else {
        return const VideosPageViewWidget();
      }
    } else if (state is VideoUploadErrorState) {
      return Center(
        child: CustomTitle(
          title: state.message,
          style: TitleStyle.style20,
        ),
      );
    }
    return const Center(
      child: CircularProgressIndicator(
        color: ColorController.whiteColor,
      ),
    );
  }

  void _favouritesListener(BuildContext context, FavouritesState state) {
    if (state is GetFavoritesErrorState) {
      ToastHelper.showToast(message: state.message);
    }
  }

  void _userInfoListener(BuildContext context, UserInfoState state) {
    if (state is GetUserInfoSuccessState) {
      UserInfoCubit.get(context).userEntity = state.userEntity!;
      print(state.userEntity?.name);
    }
  }
}
