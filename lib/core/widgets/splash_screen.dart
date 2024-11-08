import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/utils/bloc_observer.dart';
import 'package:shorts/core/widgets/initial_screen.dart';

import '../service_locator/service_locator.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Bloc.observer = MyBlocObserver();
    Firebase.initializeApp();
    setUpServiceLocator();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    WidgetsFlutterBinding.ensureInitialized();
    _navigateAfterDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Lottie.asset(
        'assets/lottie_files/videoAnimationLottie.json',
        width: MediaQuery.of(context).size.width * 0.5,
      ),

      // Image.asset(
      //   constSplashImage,
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   fit: BoxFit.cover,
      // ),
    );
  }

  void _navigateAfterDelay() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() async {
        await Future.delayed(const Duration(seconds: 4));

        if (mounted) {
          NavigationManager.navigateAndFinish(
            context: context,
            screen: const InitialScreen(),
          );
        }
      });
    });
  }
}
