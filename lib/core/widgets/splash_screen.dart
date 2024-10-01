import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/utils/bloc_observer.dart';
import 'package:shorts/core/widgets/initial_screen.dart';

import '../service_locator/service_locator.dart';

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
    WidgetsFlutterBinding.ensureInitialized();
    _navigateAfterDelay();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/images/groot.jpg',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    );
  }
  void _navigateAfterDelay() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() async {
        await Future.delayed(const Duration(seconds: 3));

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
