import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/presentation/screens/videos_list.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:shorts/core/utils/widgets/custom_title.dart';

import '../../../../core/service_locator/service_locator.dart';
import '../../domain/videos_use_cases/get_videos_use_case/get_videos_use_case.dart';
import '../../domain/videos_use_cases/upload_video_use_case/upload_video_use_case.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const CustomTitle(
              title: 'Videos', style: TitleStyle.styleBold20)),
      body: BlocProvider(
        create: (context) => VideoCubit(
          getVideosUseCase: getIt.get<GetVideosUseCase>(),
          uploadVideoUseCase: getIt.get<UploadVideoUseCase>(),
        )..getVideos(),
        child: BlocConsumer<VideoCubit, VideoState>(
          listener: (context, state) {
            if (state is GetVideoLoading) {
              const Center(child: CircularProgressIndicator());
            }
          },
          builder: (context, state) {
            return BlocBuilder<VideoCubit, VideoState>(
              builder: (context, state) {
                if (state is GetVideoSuccess) {
                  return PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.videos.length,
                    itemBuilder: (context, index) {
                      final video = state.videos[index];
                      return VideoListItem(
                        videoUrl: video.videoUrl,
                      );
                    },
                  );
                } else if (state is VideoError) {
                  return Center(
                      child: CustomTitle(
                    title: state.message,
                    style: TitleStyle.style20,
                  ));
                }
                return const Center(
                    child: CustomTitle(
                        title: 'No data available',
                        style: TitleStyle.styleBold20));
              },
            );
          },
        ),
      ),
    );
  }
}
