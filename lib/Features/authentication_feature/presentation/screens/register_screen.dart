import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/functions/toast_function.dart';
import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/user_info/domain/use_cases/get_user_info_use_case.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/verification_screen.dart';
import '../../domain/authentication_use_case/register_use_case.dart';
import '../../domain/authentication_use_case/verify_user_use_case.dart';
import '../cubit/register_cubit/register_cubit.dart';
import '../widgets/register_screen_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        registerUseCase: getIt.get<RegisterUseCase>(),
        verifyUserUseCase: getIt.get<VerifyUserUseCase>(),
        userDataUseCase: getIt.get<GetUserInfoUseCase>(),
      ),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: _listener,
        builder: _builder,
      ),
    );
  }

  Widget _builder(BuildContext context, RegisterState state) {
    return BlockInteractionLoadingWidget(
      isLoading: state is RegisterLoadingState,
      child: const Scaffold(
        backgroundColor: ColorController.blackColor,
        body: RegisterScreenBody(),
      ),
    );
  }

  void _listener(BuildContext context, RegisterState state) {
    if (state is RegisterSuccessState) {
      NavigationManager.navigateAndFinishWithTransition(
        context: context,
        screen: VerificationScreen(
          userId: state.userEntity.id!,
        ),
      );
    } else if (state is RegisterErrorState) {
      ToastHelper.showToast(
        message: state.message,
      );
    }
  }
}
