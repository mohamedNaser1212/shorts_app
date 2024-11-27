import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/follow_cubit/follow_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/get_videos_cubit/video_cubit.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';

import '../../../../Features/videos_feature/presentation/video_cubit/upload_videos_cubit/upload_videos_cubit.dart';
import '../../../../Features/videos_feature/presentation/widgets/videos_components_widgets/videos_list.dart';
import '../../../functions/navigations_functions.dart';
import '../../../widgets/custom_snack_bar.dart';
import '../../data/layouts_model.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => LayoutScreenState();
}

class LayoutScreenState extends State<LayoutScreen> {
  final LayoutModel layoutModel = LayoutModel();

  @override
  void initState() {
    super.initState();
    VideoCubit.get(context).getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UploadVideosCubit, UploadVideosState>(
          listener: (context, state) {
            if (state is VideoUploadLoadingState) {
              // Handle loading state if needed
            } else if (state is VideoUploadedSuccessState) {
              VideoCubit.get(context).videos.insert(0, state.videoEntity);
              GetUserVideosCubit.get(context)
                  .videos
                  .insert(0, state.videoEntity);
              showSnackBar(
                message: "Success At Upload",
                context: context,
                onActionPressed: () => NavigationManager.navigateTo(
                    context: context,
                    screen: VideoListItem(videoEntity: state.videoEntity)),
                actionLabel: "Show",
              );
            }
          },
        ),
        BlocListener<FollowCubit, FollowState>(
          listener: (context, state) {
            if (state is ToggleFollowSuccessState) {
              UserInfoCubit.get(context).getUserData();
            }
          },
        ),
      ],
      child: Scaffold(
        body: layoutModel.currentScreen,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor:
              Colors.black, // Set navigation bar background to black
          currentIndex: layoutModel.currentIndex,
          items: layoutModel.bottomNavigationBarItems,
          selectedItemColor: Colors.white, // Set selected icon color to white
          unselectedItemColor: Colors.grey, // Set unselected icon color to grey
          onTap: (index) {
            setState(() {
              layoutModel.changeScreen(index);
            });
          },
        ),
      ),
    );
  }
}
