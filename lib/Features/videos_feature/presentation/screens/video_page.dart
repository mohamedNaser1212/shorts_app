import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/presentation/screens/videos_list.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';

import '../../../../core/service_locator/service_locator.dart';
import '../../domain/videos_use_cases/get_videos_use_case/get_videos_use_case.dart';
import '../../domain/videos_use_cases/upload_video_use_case/upload_video_use_case.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TikTok Videos')),
      body: BlocProvider(
        create: (context) => VideoCubit(
          getVideosUseCase: getIt.get<GetVideosUseCase>(),
          uploadVideoUseCase: getIt.get<UploadVideoUseCase>(),
        )..getVideos(),
        child: BlocBuilder<VideoCubit, VideoState>(
          builder: (context, state) {
            if (state is GetVideoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetVideoSuccess) {
              return PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.videos.length,
                itemBuilder: (context, index) {
                  final video = state.videos[index];
                  return VideoListItem(videoUrl: video.videoUrl);
                },
              );
            } else if (state is VideoError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }
}
