import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/navigations_manager.dart';
import '../../../../core/functions/toast_function.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/user_info/domain/use_cases/get_user_info_use_case.dart';
import '../../../../core/utils/widgets/custom_progress_indicator.dart';
import '../../../../core/utils/widgets/initial_screen.dart';
import '../../domain/authentication_use_case/login_use_case.dart';
import '../cubit/login_cubit/login_cubit.dart';
import '../cubit/login_cubit/login_state.dart';
import '../widgets/login_screen_body.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        loginUseCase: getIt.get<LoginUseCase>(),
        userDataUseCase: getIt.get<GetUserInfoUseCase>(),
      ),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: _loginListener,
        builder: _builder,
      ),
    );
  }

  Widget _builder(BuildContext context, LoginState state) {
    return CustomProgressIndicator(
      isLoading: state is AppLoginLoadingState,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: LoginScreenBody(state: this),
      ),
    );
  }

  void _loginListener(BuildContext context, LoginState state) {
    if (state is AppLoginSuccessState) {
      NavigationManager.navigateAndFinish(
          context: context, screen: const InitialScreen());
    } else if (state is AppLoginErrorState) {
      showToast(
        message: state.error,
      );
    }
  }
}
