import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:shorts/core/navigations_manager/navigations_manager.dart';
import 'package:shorts/core/service_locator/service_locator.dart';
import 'package:shorts/core/utils/widgets/custom_title.dart';

import 'Features/videos_feature/presentation/screens/video_page.dart';
import 'core/utils/widgets/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<VideoCubit>()..getVideos(),
        ),
      ],
      child: MaterialApp(
        title: 'TikTok Clone',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => context.read<VideoCubit>().uploadVideo(),
              child: const CustomTitle(
                title: 'Select Video',
                style: TitleStyle.style18,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                NavigationManager.navigateTo(
                    context: context, screen: const VideoPage());
              },
              child: const CustomTitle(
                title: 'View Videos',
                style: TitleStyle.style18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
