import 'package:flutter/material.dart';
import 'package:shorts/core/utils/widgets/reusable_elevated_botton.dart';

import '../../../Features/authentication_feature/data/user_model/login_request_model.dart';
import '../../../Features/authentication_feature/data/user_model/register_request_model.dart';
import '../../../Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import '../../../Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import '../../../Features/authentication_feature/presentation/screens/login_screen.dart';
import '../../../Features/authentication_feature/presentation/widgets/register_screen_body.dart';
import '../styles_manager/color_manager.dart';

// ignore: must_be_immutable
class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton._({
    required this.onPressed,
    required this.label,
  });

  final VoidCallback onPressed;
  final String label;
  Color? backColor;

  factory CustomElevatedButton.loginButton({
    required LoginScreenState state,
    required BuildContext context,
  }) {
    return CustomElevatedButton._(
      onPressed: () => _loginAction(state, context),
      label: 'Login',
    );
  }

  factory CustomElevatedButton.registerButton({
    required BuildContext context,
    required RegisterScreenBodyState state,
  }) {
    return CustomElevatedButton._(
      onPressed: () => _registerAction(context, state),
      label: 'Register',
    );
  }

  // factory CustomElevatedButton.checkOutButton({
  //   required BuildContext context,
  //   required num total,
  // }) {
  //   return CustomElevatedButton._(
  //     onPressed: () => _checkoutAction(context, total),
  //     label: 'CheckOut',
  //   );
  // }

  // factory CustomElevatedButton.updateButton({
  //   required BuildContext context,
  //   required SettingsScreenState userState,
  //   required GlobalKey<FormState> formKey,
  // }) {
  //   return CustomElevatedButton._(
  //     onPressed: () => _updateAction(context, userState, formKey),
  //     label: 'Update',
  //   );
  // }
  //
  // factory CustomElevatedButton.signOutButton({
  //   required BuildContext context,
  // }) {
  //   return CustomElevatedButton._(
  //     onPressed: () => _signOutAction(context),
  //     label: 'Sign Out',
  //   );
  // }

  static void _loginAction(LoginScreenState state, BuildContext context) {
    if (state.formKey.currentState!.validate()) {
      LoginCubit.get(context).login(
        requestModel: LoginRequestModel(
          email: state.emailController.text,
          password: state.passwordController.text,
        ),
      );
    }
  }

  static void _registerAction(
      BuildContext context, RegisterScreenBodyState state) {
    if (state.formKey.currentState!.validate()) {
      RegisterCubit.get(context).userRegister(
        requestModel: RegisterRequestModel(
          email: state.emailController.text,
          password: state.passwordController.text,
          name: state.nameController.text,
          phone: state.phoneController.text,
        ),
      );
    }
  }

  // static void _checkoutAction(BuildContext context, num total) {
  //   PaymentCubit.get(context).getClientSecret(
  //     amount: total.toInt(),
  //     currency: 'EGP',
  //   );
  // }

  // static void _updateAction(
  //   BuildContext context,
  //   SettingsScreenState userState,
  //   GlobalKey<FormState> formKey,
  // ) {
  //   if (formKey.currentState!.validate()) {
  //     final cubit = UpdateUserDataCubit.get(context);
  //     UpdateUserDataCubit.get(context).userModel =
  //         UserInfoCubit.get(context).userEntity;
  //     if (cubit.checkDataChanges(
  //       name: userState.nameController.text,
  //       email: userState.emailController.text,
  //       phone: userState.phoneController.text,
  //     )) {
  //       cubit.updateUserData(
  //         updateUserRequestModel: UpdateUserRequestModel(
  //           name: userState.nameController.text,
  //           email: userState.emailController.text,
  //           phone: userState.phoneController.text,
  //         ),
  //       );
  //     } else {
  //       showToast(
  //         message: 'No changes detected. Your data is up-to-date.',
  //         color: ColorController.greenAccent,
  //       );
  //     }
  //   }
  // }

  // static void _signOutAction(BuildContext context) {
  //   SignOutCubit.get(context).signOut();
  // }

  @override
  Widget build(BuildContext context) {
    return ReusableElevatedButton(
      label: label,
      backColor: backColor ?? ColorController.blueAccent,
      onPressed: onPressed,
    );
  }
}
