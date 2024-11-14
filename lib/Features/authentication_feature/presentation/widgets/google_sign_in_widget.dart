import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/widgets/initial_screen.dart';

import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title.dart';
import '../../../../core/widgets/verification_screen.dart';
import '../cubit/google_sign_in_cubit/google_sign_in_cubit.dart';

class GoogleSignInWidget extends StatelessWidget {
  const GoogleSignInWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleSignInCubit, GoogleSignInState>(
      listener: _listener,
      builder: (context, state) {
        return InkWell(
          onTap: () {
            GoogleSignInCubit.get(context).signInWithGoogle();
          },
          child: Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.07,
            decoration: BoxDecoration(
              color: ColorController.purpleColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.google,
                  color: ColorController.whiteColor,
                ),
                SizedBox(width: 10),
                CustomTitle(
                  title: 'Use Google Account',
                  style: TitleStyle.styleBold20,
                  color: ColorController.whiteColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _listener(context, state) {
    if (state is GoogleSignInSuccessState) {
      UserInfoCubit.get(context).userEntity = state.userEntity;

      if (state.userEntity.isVerified) {
        NavigationManager.navigateAndFinish(
          context: context,
          screen: const InitialScreen(),
        );
      } else {
        NavigationManager.navigateAndFinish(
          context: context,
          screen: const VerificationScreen(),
        );
      }
    }
  }
}
