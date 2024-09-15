import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/layout/presentation/screens/home_page.dart';

import '../../../../Features/authentication_feature/presentation/screens/login_screen.dart';
import '../../../navigations_manager/navigations_manager.dart';
import '../../../service_locator/service_locator.dart';
import '../../../user_info/cubit/user_info_cubit.dart';
import '../../../user_info/domain/use_cases/get_user_info_use_case.dart';
import '../custom_title.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserInfoCubit>(
      create: (context) => UserInfoCubit(
        getUserUseCase: getIt<GetUserInfoUseCase>(),
      )..getUserData(),
      child: BlocListener<UserInfoCubit, UserInfoState>(
        listener: (context, state) {
          if (state is GetUserInfoSuccessState) {
            if (state.userModel == null) {
              NavigationManager.navigateAndFinish(
                context: context,
                screen: LoginScreen(),
              );
            } else {
              print(state.userModel!.name);
              UserInfoCubit.get(context).userEntity = state.userModel;

              NavigationManager.navigateAndFinish(
                context: context,
                screen: MyHomePage(),
              );
            }
          }
        },
        child: BlocBuilder<UserInfoCubit, UserInfoState>(
          builder: (context, state) {
            if (state is GetUserInfoLoadingState) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is GetUserInfoErrorState) {
              print(state.message);
              return Scaffold(
                body: Center(
                  child: CustomTitle(
                      title: state.message, style: TitleStyle.style16),
                ),
              );
            }
            return const Scaffold(
              body: SizedBox(),
            );
          },
        ),
      ),
    );
  }
}
