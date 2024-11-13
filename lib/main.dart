import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/authentication_feature/presentation/cubit/google_sign_in_cubit/google_sign_in_cubit.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/add_comments_cubit/add_comments_cubit.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/get_favourites_cubit/favourites_cubit.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/toggle_favourites_cubit/toggle_favourites_cubit_cubit.dart';
import 'package:shorts/Features/search/presentation/cubit/search_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/get_videos_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/share_video_cubit/share_videos_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/upload_videos_cubit/upload_videos_cubit.dart';
import 'package:shorts/core/service_locator/service_locator.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';

import 'core/utils/constants/consts.dart';
import 'core/widgets/splash_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<VideoCubit>()
            ..getVideos(
              page: 0,
            ),
        ),
        BlocProvider(
          create: (context) => getIt<UserInfoCubit>()..getUserData(),
        ),
        BlocProvider(
          create: (context) => getIt<FavouritesCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<CommentsCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<UploadVideosCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ToggleFavouritesCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<AddCommentsCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<ShareVideosCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<GoogleSignInCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<SearchCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
