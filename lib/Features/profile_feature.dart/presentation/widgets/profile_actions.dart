import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/authentication_feature/presentation/screens/login_screen.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/get_favourites_cubit/favourites_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/follow_cubit/follow_cubit.dart';
import 'package:shorts/core/functions/toast_function.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_container_widget.dart';
import '../../../../core/widgets/custom_title.dart';
import '../../../authentication_feature/presentation/cubit/sign_out_cubit/sign_out_cubit.dart';
import '../screens/edit_profile_screen.dart';

class ProfileActions extends StatelessWidget {
  const ProfileActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: CustomContainerWidget(
              title: 'Edit Profile',
              titleStyle: TitleStyle.styleBold18,
              onTap: () {
                NavigationManager.navigateTo(
                  context: context,
                  screen: const EditProfileScreen(),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          BlocConsumer<SignOutCubit, SignOutState>(
            listener: (context, state) {
              if (state is SignOutSuccessState) {
                NavigationManager.navigateAndFinish(
                  context: context,
                  screen: const LoginScreen(),
                );
                FollowCubit.get(context).reset();
                //   UserInfoCubit.get(context).reset();
                FavouritesCubit.get(context).reset();
              } else if (state is SignOutErrorState) {
                ToastHelper.showToast(message: state.error);
              }
            },
            builder: (context, state) {
              return Expanded(
                child: CustomContainerWidget(
                  titleStyle: TitleStyle.styleBold18,
                  title: 'Log Out',
                  containerColor: ColorController.redColor,
                  onTap: () {
                    SignOutCubit.get(context).signOut();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
