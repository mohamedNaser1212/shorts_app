import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/get_videos_use_case/get_videos_use_case.dart';
import 'package:shorts/Features/videos_feature/domain/videos_use_cases/upload_video_use_case/upload_video_use_case.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:shorts/core/navigations_manager/navigations_manager.dart';
import 'package:shorts/core/service_locator/service_locator.dart';
import 'package:shorts/core/utils/bloc_observer.dart';

import '../../../../Features/layout/presentation/screens/home_page.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() async {
        await Future.delayed(const Duration(seconds: 5));

        if (mounted) {
          NavigationManager.navigateAndFinish(
            context: context,
            screen: BlocProvider(
              create: (context) => VideoCubit(
                getVideosUseCase: getIt.get<GetVideosUseCase>(),
                uploadVideoUseCase: getIt.get<UploadVideoUseCase>(),
              ),
              child: const MyHomePage(),
            ),
          );
        }
      });
    });
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

//import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:shop_app/Features/authentication_feature/presentation/screens/login_screen.dart';
// import 'package:shop_app/Features/layout/presentation/screens/layout_screen.dart';
// import 'package:shop_app/core/managers/navigations_manager/navigations_manager.dart';
// import 'package:shop_app/core/service_locator/service_locator.dart';
//
// import '../payment_gate_way_manager/stripe_payment/stripe_keys.dart';
// import '../user_info/cubit/user_info_cubit.dart';
// import '../user_info/domain/use_cases/get_user_info_use_case.dart';
// import '../utils/bloc_observer/bloc_observer.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   Future<void> initState() async {
//     super.initState();
//
//     Bloc.observer = MyBlocObserver();
//     Stripe.publishableKey = ApiKeys.publishableKey;
//
//     // userInfoCubit.getUserData();
//     // ProductsCubit.get(context).getProductsData(context: context);
//     setUpServiceLocator();
//   }
//
//   UserInfoCubit userInfoCubit = getIt<UserInfoCubit>();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => UserInfoCubit(
//         getUserUseCase: getIt.get<GetUserInfoUseCase>(),
//       )..getUserData(),
//       child: BlocConsumer<UserInfoCubit, UserInfoState>(
//         listener: (context, state) {
//           if (state is GetUserInfoSuccessState) {
//             NavigationManager.navigateAndFinish(
//                 context: context, screen: const LayoutScreen());
//           } else if (state is GetUserInfoErrorState) {
//             NavigationManager.navigateAndFinish(
//                 context: context, screen: LoginScreen());
//           }
//         },
//         builder: (context, state) {
//           return Scaffold(
//             body: Image.asset(
//               'assets/images/groot.jpg',
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               fit: BoxFit.cover,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
