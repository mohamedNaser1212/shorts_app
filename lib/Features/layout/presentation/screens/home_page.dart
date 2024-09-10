import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/upload_video_use_case/upload_video_use_case.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:shorts/core/navigations_manager/navigations_manager.dart';
import 'package:shorts/core/service_locator/service_locator.dart';

import '../../../../core/utils/widgets/custom_title.dart';
import '../../../videos_feature/domain/videos_use_cases/get_videos_use_case/get_videos_use_case.dart';
import '../../../videos_feature/presentation/screens/video_page.dart';
import 'choose_video_page.dart'; // Import the new page

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoCubit(
        uploadVideoUseCase: getIt.get<UploadVideoUseCase>(),
        getVideosUseCase: getIt.get<GetVideosUseCase>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  NavigationManager.navigateTo(
                    context: context,
                    screen: const ChooseVideoPage(),
                  );
                },
                child: const CustomTitle(
                  title: 'Select Video',
                  style: TitleStyle.style18,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  NavigationManager.navigateTo(
                    context: context,
                    screen: const VideoPage(),
                  );
                },
                child: const CustomTitle(
                  title: 'View Videos',
                  style: TitleStyle.style18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
