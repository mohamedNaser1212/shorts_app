import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/presentation/screens/videos_list.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/utils/widgets/custom_title.dart';

import '../../../../core/service_locator/service_locator.dart';
import '../../../favourites_feature/domain/favourites_use_case/favourites_use_case.dart';
import '../../../favourites_feature/presentation/cubit/favourites_cubit.dart';
import '../../domain/videos_use_cases/get_videos_use_case/get_videos_use_case.dart';
import '../../domain/videos_use_cases/upload_video_use_case/upload_video_use_case.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTitle(
          title: 'Videos',
          style: TitleStyle.styleBold20,
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => VideoCubit(
              getVideosUseCase: getIt.get<GetVideosUseCase>(),
              uploadVideoUseCase: getIt.get<UploadVideoUseCase>(),
            )..getVideos(),
          ),
          BlocProvider(
            create: (context) => FavouritesCubit(
              favouritesUseCase: getIt.get<FavouritesUseCase>(),
            ),
          ),
        ],
        child: BlocConsumer<UserInfoCubit, UserInfoState>(
          listener: (context, UserState) {
            if (UserState is GetUserInfoSuccessState) {
              print(UserState.userModel?.name);
              print(UserState.userModel?.id);
              print(UserState.userModel?.phone);
              print(UserState.userModel?.email);
              print(UserState.userModel?.fcmToken);
            }
          },
          builder: (context, state) {
            return BlocConsumer<FavouritesCubit, FavouritesState>(
              listener: (context, state) {},
              builder: (context, state) {
                return BlocConsumer<VideoCubit, VideoState>(
                  listener: (context, state) {
                    if (state is GetVideoLoading) {
                      const Center(child: CircularProgressIndicator());
                    }
                  },
                  builder: (context, state) {
                    if (state is GetVideoSuccess) {
                      // FavouritesCubit.get(context).favorites = {
                      //   for (var p in state.videos) p.id: p.isFavourite ?? false
                      // };
                      return PageView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: state.videos.length,
                        itemBuilder: (context, index) {
                          final video = state.videos[index];
                          return VideoListItem(
                            videoEntity: video,
                            userModel: UserInfoCubit.get(context).userEntity!,
                          );
                        },
                      );
                    } else if (state is VideoError) {
                      return Center(
                        child: CustomTitle(
                          title: state.message,
                          style: TitleStyle.style20,
                        ),
                      );
                    }
                    return const Center(
                      child: CustomTitle(
                        title: 'No data available',
                        style: TitleStyle.styleBold20,
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
