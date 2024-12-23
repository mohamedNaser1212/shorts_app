import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/get_favourites_cubit/favourites_cubit.dart';

import '../../Features/authentication_feature/presentation/screens/login_screen.dart';
import '../functions/navigations_functions.dart';
import '../layout/presentation/screens/layout_widget.dart';
import '../managers/styles_manager/color_manager.dart';
import '../user_info/cubit/user_info_cubit.dart';
import 'connection_failure_widget.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});
  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    UserInfoCubit.get(context).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserInfoCubit, UserInfoState>(
      listener: _listener,
      builder: _userInfoBuilder,
    );
  }

  Widget _userInfoBuilder(context, state) {
    if (state is GetUserInfoLoadingState) {
      return const Scaffold(
        backgroundColor: ColorController.blackColor,
        body: Center(
          child: CircularProgressIndicator(
            color: ColorController.whiteColor,
          ),
        ),
      );
    } else if (state is GetUserInfoErrorState) {
      return Scaffold(
        backgroundColor: ColorController.blackColor,
        body: Center(
          child: ConnectionFailureWidget(
            onPressed: () {
              UserInfoCubit.get(context).getUserData();
            },
          ),
        ),
      );
    }
    return const SizedBox();
  }

  void _listener(context, state) {
    if (state is GetUserInfoSuccessState) {
      if (state.userEntity == null) {
        NavigationManager.navigateAndFinish(
          context: context,
          screen: const LoginScreen(),
        );
      } else if (!state.userEntity!.isVerified) {
        NavigationManager.navigateAndFinish(
          context: context,
          screen: const LoginScreen(),
        );
      } else {
        UserInfoCubit.get(context).userEntity = state.userEntity;
        FavouritesCubit.get(context).getFavourites(user: state.userEntity!);
        NavigationManager.navigateAndFinish(
          context: context,
          screen: const LayoutScreen(),
        );
      }
    }
  }
}
