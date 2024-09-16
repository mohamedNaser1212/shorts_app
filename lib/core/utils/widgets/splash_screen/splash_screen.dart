import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shorts/core/navigations_manager/navigations_manager.dart';
import 'package:shorts/core/service_locator/service_locator.dart';
import 'package:shorts/core/utils/bloc_observer.dart';
import 'package:shorts/core/utils/widgets/initial_screen/initial_screen.dart';

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

    WidgetsFlutterBinding.ensureInitialized();

    _initializeHiveAndServices();
  }

  Future<void> _initializeHiveAndServices() async {
    try {
      await Hive.initFlutter();
      await setUpServiceLocator();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.microtask(() async {
          await Future.delayed(const Duration(seconds: 5));

          if (mounted) {
            NavigationManager.navigateAndFinish(
              context: context,
              screen: const InitialScreen(),
            );
          }
        });
      });
    } catch (e) {
      print('Failed to initialize Hive and services: $e');
    }
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
}
