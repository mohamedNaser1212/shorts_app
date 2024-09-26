import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shorts/Features/layout/presentation/screens/home_page.dart';

import '../../../../core/navigations_manager/navigations_manager.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/user_info/cubit/user_info_cubit.dart';
import '../../../../core/user_info/domain/use_cases/get_user_info_use_case.dart';
import '../../../../core/utils/styles_manager/text_styles_manager.dart';
import '../../../../core/utils/widgets/custom_title.dart';
import '../../../../core/utils/widgets/reusable_widgets_manager/reusable_elevated_botton.dart';
import '../../../../core/utils/widgets/reusable_widgets_manager/reusable_text_form_field.dart';
import '../../domain/authentication_repo/authentication_repo.dart';
import '../../domain/authentication_use_case/register_use_case.dart';
import '../cubit/register_cubit/register_cubit.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterCubit(
            registerUseCase: RegisterUseCase(
              authenticationRepo: getIt.get<AuthenticationRepo>(),
            ),
            userDataUseCase: getIt.get<GetUserInfoUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => UserInfoCubit(
            getUserUseCase: getIt.get<GetUserInfoUseCase>(),
          ),
        ),
      ],
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: _listener,
        builder: (context, state) => _buildRegisterScreen(context, state),
      ),
    );
  }
}

Future<void> _listener(BuildContext context, RegisterState state) async {
  if (state is RegisterSuccessState) {
    Fluttertoast.showToast(
      msg: 'Register Successfully',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    final userInfoCubit = context.read<UserInfoCubit>();
    userInfoCubit.userEntity = state.userModel;
    NavigationManager.navigateAndFinish(
      context: context,
      screen: MyHomePage(
        currentUser: state.userModel,
      ),
    );
  } else if (state is RegisterErrorState) {
    Fluttertoast.showToast(
      msg: state.message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

Widget _buildRegisterScreen(BuildContext context, RegisterState state) {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'REGISTER',
                  style: StylesManager.textStyle30,
                ),
                const SizedBox(height: 15),
                ReusableTextFormField(
                  label: 'Email',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefix: const Icon(Icons.email_rounded),
                ),
                const SizedBox(height: 10),
                ReusableTextFormField(
                  label: 'Password',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscure: RegisterCubit.get(context).obsecurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  prefix: const Icon(Icons.key_rounded),
                  suffix: IconButton(
                    onPressed: () {
                      // RegisterCubit.get(context).changePasswordVisibility();
                    },
                    icon: Icon(RegisterCubit.get(context).suffixPasswordIcon),
                  ),
                ),
                const SizedBox(height: 10),
                ReusableTextFormField(
                  label: 'Name',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Name must not be empty';
                    }
                    return null;
                  },
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  prefix: const Icon(Icons.person),
                ),
                const SizedBox(height: 10),
                ReusableTextFormField(
                  label: 'Phone',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Phone must not be empty';
                    }
                    return null;
                  },
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  prefix: const Icon(Icons.phone),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      const CustomTitle(
                        style: TitleStyle.style16,
                        title: 'Already have an account? ',
                      ),
                      TextButton(
                        onPressed: () {
                          NavigationManager.navigateAndFinish(
                            context: context,
                            screen: LoginScreen(),
                          );
                        },
                        child: const CustomTitle(
                          style: TitleStyle.styleBold18,
                          title: 'Login Now',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ConditionalBuilder(
                    condition: state is! RegisterLoadingState,
                    builder: (context) => ReusableElevatedButton(
                      label: 'Register',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          RegisterCubit.get(context).userRegister(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                    ),
                    fallback: (context) => const CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
