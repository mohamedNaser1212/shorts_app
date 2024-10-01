import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/core/widgets/custom_app_bar.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/functions/toast_function.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/user_info/cubit/user_info_cubit.dart';
import '../../../../core/user_info/domain/use_cases/get_user_info_use_case.dart';
import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/initial_screen.dart';
import '../../domain/authentication_use_case/register_use_case.dart';
import '../cubit/register_cubit/register_cubit.dart';
import '../widgets/register_screen_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        registerUseCase: getIt.get<RegisterUseCase>(),
        userDataUseCase: getIt.get<GetUserInfoUseCase>(),
      ),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: _listener,
        builder: _builder,
      ),
    );
  }

  Widget _builder(BuildContext context, RegisterState state) {
    return CustomProgressIndicator(
      isLoading: state is RegisterLoadingState,
      child: Scaffold(
        appBar: AppBar(
          title: CustomAppBar(title:'Register'),
        ),
        body: const RegisterScreenBody(),
      ),
    );
  }
}

void _listener(BuildContext context, RegisterState state) {
  if (state is RegisterSuccessState) {
    showToast(
      color: ColorController.greenAccent,
      message: 'Register Success',
    );

    UserInfoCubit.get(context).userEntity = state.userModel;

    NavigationManager.navigateAndFinish(
      context: context,
      screen: const InitialScreen(),
    );
  } else if (state is RegisterErrorState) {
    showToast(
      message: state.message,
    );
  }
}
