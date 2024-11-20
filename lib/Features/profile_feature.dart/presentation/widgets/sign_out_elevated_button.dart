import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/authentication_feature/presentation/screens/login_screen.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/screens/edit_profile_screen.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/widgets/custom_elevated_botton.dart';

class SignOutElevatedButton extends StatelessWidget {
  const SignOutElevatedButton({super.key, required this.editState});
  final EditProfileScreenState editState;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserInfoCubit, UserInfoState>(
      listener: (context, state) {
        if (state is SignOutSuccessState) {
          NavigationManager.navigateAndFinish(
              context: context, screen: const LoginScreen());
        } else if (state is SignOutErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        } else if (state is SignOutLoadingState) {
          NavigationManager.navigateAndFinish(
              context: context, screen: const LoginScreen());
        }
      },
      builder: (context, state) {
        // bool isLoading = state is SignOutLoadingState;

        return CustomElevatedButton.signOutElevatedButton(
          context: context,
        );
      },
    );
  }
}
