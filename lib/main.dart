import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:shorts/Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/comments_cubit.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:shorts/core/service_locator/service_locator.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/utils/widgets/splash_screen/splash_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  // await _firebaseMessaging.subscribeToTopic('all_users');

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
        BlocProvider(
          create: (context) => getIt<UserInfoCubit>()..getUserData(),
        ),
        BlocProvider(
          create: (context) => getIt<FavouritesCubit>()..getFavourites(),
        ),
        BlocProvider(
          create: (context) => getIt<CommentsCubit>(),
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
