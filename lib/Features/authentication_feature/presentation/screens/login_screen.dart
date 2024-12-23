import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/core/widgets/verification_screen.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/functions/toast_function.dart';
import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/user_info/domain/use_cases/get_user_info_use_case.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/initial_screen.dart';
import '../../domain/authentication_use_case/login_use_case.dart';
import '../../domain/authentication_use_case/verify_user_use_case.dart';
import '../cubit/login_cubit/login_cubit.dart';
import '../cubit/login_cubit/login_state.dart';
import '../widgets/login_screen_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        loginUseCase: getIt.get<LoginUseCase>(),
        userDataUseCase: getIt.get<GetUserInfoUseCase>(),
        verifyUserUseCase: getIt.get<VerifyUserUseCase>(),
      ),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: _loginListener,
        builder: _builder,
      ),
    );
  }

  Widget _builder(BuildContext context, LoginState state) {
    return BlockInteractionLoadingWidget(
      isLoading: state is LoginLoadingState,
      child: const Scaffold(
        backgroundColor: ColorController.blackColor,
        body: LoginScreenBody(),
      ),
    );
  }

  void _loginListener(BuildContext context, LoginState state) {
    if (state is LoginSuccessState) {
      if (state.userEntity.isVerified) {
        NavigationManager.navigateAndFinish(
          context: context,
          screen: const InitialScreen(),
        );
      } else {
        NavigationManager.navigateToWithTransition(
          context: context,
          screen: VerificationScreen(
            userId: state.userEntity.id!,
          ),
        );
      }
    } else if (state is LoginErrorState) {
      ToastHelper.showToast(
        message: state.error,
      );
    }
    // else if (state is VerificationSuccessState) {
    //   if (state.isVerified) {
    //     NavigationManager.navigateAndFinish(
    //       context: context,
    //       screen: const InitialScreen(),
    //     );
    //   }
    // } else if (state is VerificationErrorState) {
    //   ToastHelper.showToast(
    //     message: state.errMessage,
    //   );
    // }
  }
}
