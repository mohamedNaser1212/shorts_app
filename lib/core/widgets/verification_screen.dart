import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/authentication_feature/presentation/screens/login_screen.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/widgets/custom_app_bar.dart';
import 'package:shorts/core/widgets/custom_icon_widget.dart';

import '../../Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import '../managers/styles_manager/color_manager.dart';
import 'custom_title.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, required this.userId});
  final String userId;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startVerificationListener();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    RegisterCubit.get(context).stopVerificationListener();
    super.dispose();
  }

  void _startVerificationListener() {
    final cubit = RegisterCubit.get(context);
    cubit.startVerificationListener(userId: widget.userId);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startVerificationListener();
    } else if (state == AppLifecycleState.paused) {
      RegisterCubit.get(context).stopVerificationListener();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is VerificationSuccessState) {
          if (state.isVerified) {
            NavigationManager.navigateAndFinish(
              context: context,
              screen: const LoginScreen(),
            );
          }
        } else if (state is RegisterErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: const Scaffold(
        backgroundColor: ColorController.blackColor,
        appBar: CustomAppBar(
          title: 'Verify Account',
          titleStyle: TitleStyle.styleBold22,
          backColor: Colors.green,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomIconWidget(
                icon: Icons.verified_user_rounded,
                color: ColorController.greenColor,
                size: 150,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: CustomTitle(
                  title:
                      'Verification Link Sent to your Email, PleaSe Check Your Email To Verify Your Account',
                  style: TitleStyle.style20,
                  wordSpacing: 2,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
