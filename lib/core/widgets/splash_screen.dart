import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shorts/core/utils/bloc_observer.dart';

import '../functions/navigations_functions.dart';
import '../managers/styles_manager/color_manager.dart';
import '../service_locator/service_locator.dart';
import 'initial_screen.dart';

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
      backgroundColor: ColorController.blackColor,
      body: Center(
        child: Lottie.asset(
          'assets/lottie_files/splash.json',
        ),
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
