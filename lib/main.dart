import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:shorts/Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:shorts/core/service_locator/service_locator.dart';

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
          create: (context) => getIt<LoginCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<RegisterCubit>(),
        ),
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
