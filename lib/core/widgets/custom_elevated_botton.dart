import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/login_screen_body.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_screen_form.dart';
import 'package:shorts/Features/favourites_feature/presentation/screens/favourites_screen.dart';
import 'package:shorts/Features/videos_feature/presentation/screens/video_page.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';
import 'package:shorts/core/widgets/reusable_elevated_botton.dart';

import '../../Features/authentication_feature/data/user_model/login_request_model.dart';
import '../../Features/authentication_feature/data/user_model/register_request_model.dart';
import '../../Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import '../../Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import '../../Features/videos_feature/presentation/widgets/trimmer_view.dart';
import '../managers/styles_manager/color_manager.dart';

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
    required LoginScreenBodyState state,
    required BuildContext context,
  }) {
    return CustomElevatedButton._(
      onPressed: () => _loginAction(state, context),
      label: 'Login',
    );
  }

  factory CustomElevatedButton.registerButton({
    required BuildContext context,
    required RegisterScreenFormState state,
  }) {
    return CustomElevatedButton._(
      onPressed: () => _registerAction(context, state),
      label: 'Register',
    );
  }

  factory CustomElevatedButton.favouritesPageBotton({
    required BuildContext context,
    required UserEntity currentUser,
  }) {
    return CustomElevatedButton._(
      onPressed: () => _navigateToFavouritesPage(context, currentUser),
      label: 'Favourites',
    );
  }

  factory CustomElevatedButton.videoPageBotton({
    required BuildContext context,
  }) {
    return CustomElevatedButton._(
      onPressed: () => _navigateToVideoPage(context),
      label: 'Videos',
    );
  }

  factory CustomElevatedButton.chooseVideoPageBotton({
    required BuildContext context,
  }) {
    return CustomElevatedButton._(
      onPressed: () => _navigateToChooseVideoPage(context),
      label: 'Upload Video',
    );
  }

  static void _loginAction(LoginScreenBodyState state, BuildContext context) {
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
      BuildContext context, RegisterScreenFormState state) {
    if (state.widget.formKey.currentState!.validate()) {
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

  // Private navigation methods
  static void _navigateToFavouritesPage(
      BuildContext context, UserEntity currentUser) {
    NavigationManager.navigateTo(
      context: context,
      screen: FavouritesPage(currentUser: currentUser),
    );
  }

  static void _navigateToVideoPage(BuildContext context) {
    NavigationManager.navigateTo(
      context: context,
      screen: const VideoPage(),
    );
  }

  static Future<void> _navigateToChooseVideoPage(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowCompression: true,
    );
    if (result != null) {
      final file = File(result.files.single.path!);

      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => TrimmerView(file: file)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReusableElevatedButton(
      label: label,
      backColor: backColor ?? ColorController.blueAccent,
      onPressed: onPressed,
    );
  }
}
