import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/widgets/custom_container_widget.dart';
import 'package:shorts/core/widgets/initial_screen.dart';

import '../../../../core/widgets/custom_title.dart';
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
          onTap: () => _onTap(context: context),
          child: CustomContainerWidget(
            height: MediaQuery.of(context).size.height * 0.07,
            title: 'Use Google Account',
            titleStyle: TitleStyle.styleBold20,
            icon: FontAwesomeIcons.google,
            onTap: () => _onTap(context: context),
          ),
        );
      },
    );
  }

  void _onTap({
    required BuildContext context,
  }) {
    GoogleSignInCubit.get(context).signInWithGoogle();
  }

  void _listener(context, state) {
    if (state is GoogleSignInSuccessState) {
      UserInfoCubit.get(context).userEntity = state.userEntity;

      NavigationManager.navigateAndFinish(
        context: context,
        screen: const InitialScreen(),
      );
    }
  }
}
