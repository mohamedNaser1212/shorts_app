import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/login_screen_body.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_screen_form.dart';
import 'package:shorts/Features/favourites_feature/presentation/screens/favourites_screen.dart';
import 'package:shorts/Features/profile_feature.dart/domain/update_model/update_request_model.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/update_user_cubit/update_user_data_cubit.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/Features/videos_feature/presentation/screens/video_page.dart';

import 'package:shorts/Features/videos_feature/presentation/video_cubit/upload_videos_cubit/upload_videos_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/preview_screen.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/functions/toast_function.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';
import 'package:shorts/core/widgets/email_verification_dialogue_widget.dart';
import 'package:shorts/core/widgets/reusable_elevated_botton.dart';
import 'package:uuid/uuid.dart';
import '../../Features/authentication_feature/data/user_model/login_request_model.dart';
import '../../Features/authentication_feature/data/user_model/register_request_model.dart';
import '../../Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import '../../Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import '../../Features/profile_feature.dart/presentation/screens/edit_profile_screen.dart';
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
  factory CustomElevatedButton.editProfileButton({
    required BuildContext context,
    required EditProfileScreenState state,
  }) {
    return CustomElevatedButton._(
      onPressed: () => _editProfileButtonOnPressed(
        context: context,
        editState: state,
      ),
      label: 'Edit Profile',
    );
  }
  factory CustomElevatedButton.signOutElevatedButton({
    required BuildContext context,
  }) {
    return CustomElevatedButton._(
      onPressed: () => _signOutOnPressed(context: context),
      label: 'Sign Out',
    );
  }

  factory CustomElevatedButton.favouritesPageButton({
    required BuildContext context,
    required UserEntity currentUser,
  }) {
    return CustomElevatedButton._(
      onPressed: () => _navigateToFavouritesPage(
        context: context,
        currentUser: currentUser,
      ),
      label: 'Favourites',
    );
  }
  factory CustomElevatedButton.editProfilePage({
    required BuildContext context,
  }) {
    return CustomElevatedButton._(
      onPressed: () => _navigateToEditProfilePage(
        context: context,
      ),
      label: 'Edit Profile',
    );
  }
  factory CustomElevatedButton.editProfileImagePickerButton({
    required BuildContext context,
    required EditProfileScreenState editState,
  }) {
    return CustomElevatedButton._(
      label: 'Change Profile Picture',
      onPressed: editState.imageNotifierController.pickImage,
    );
  }

  factory CustomElevatedButton.uploadVideo({
    required BuildContext context,
    required PreviewScreenState previewState,
    required File? thumbnailFile,
  }) {
    return CustomElevatedButton._(
      onPressed: () => _uploadVideoOnPressed(
        context: context,
        previewState: previewState,
        thumbnailFile: thumbnailFile,
      ),
      label: 'Upload Video',
    );
  }

  factory CustomElevatedButton.videoPageButton({
    required BuildContext context,
  }) {
    return CustomElevatedButton._(
      onPressed: () => _navigateToVideoPage(context),
      label: 'Videos',
    );
  }

  factory CustomElevatedButton.chooseVideoPageButton({
    required BuildContext context,
  }) {
    return CustomElevatedButton._(
      // onPressed: onPressed,
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

  static void _signOutOnPressed({
    required BuildContext context,
  }) {
    UserInfoCubit.get(context).signOut();
  }

  static void _editProfileButtonOnPressed({
    required BuildContext context,
    required EditProfileScreenState editState,
  }) async {
    final cubit = UpdateUserDataCubit.get(context);
    final userCubit = UserInfoCubit.get(context);

    final currentEmail = userCubit.userEntity!.email;
    final newEmail = editState.emailController.text;
    final newName = editState.nameController.text;
    final newPhone = editState.phoneController.text;

    if (currentEmail != newEmail) {
      final shouldUpdateEmail = await showDialog<bool>(
        context: context,
        builder: (context) {
          return const EmailVerificationDialogueWidget();
        },
      );

      if (shouldUpdateEmail == false) {
        return;
      }
    }

    cubit.updateUserData(
      updateUserRequestModel: UpdateUserRequestModel(
        name: newName,
        email: newEmail,
        phone: newPhone,
        imageUrl:
            editState.imageNotifierController.profilePicNotifier.value ?? '',
      ),
      userId: userCubit.userEntity!.id!,
    );
  }

  static Future<void> _registerAction(
      BuildContext context, RegisterScreenFormState state) async {
    if (state.widget.formKey.currentState!.validate()) {
      print(
          'image url ${state.imageNotifierController.profilePicNotifier.value}');
      if (state.imageNotifierController.profilePicNotifier.value != null) {
        state.imageNotifierController.uploadImage();
        print('image is uploaded');
      }
      RegisterCubit.get(context).userRegister(
        requestModel: RegisterRequestModel(
          email: state.emailController.text,
          password: state.passwordController.text,
          name: state.nameController.text,
          phone: state.phoneController.text,
          bio: state.bioController.text.isNotEmpty
              ? state.bioController.text
              : 'Hey there i am using Shorts',
          profilePic:
              state.imageNotifierController.profilePicNotifier.value ?? '',
        ),
      );
    }
  }

  static void _uploadVideoOnPressed({
    required BuildContext context,
    required PreviewScreenState previewState,
    required File? thumbnailFile,
  }) {
    const Uuid uuid = Uuid();

    if (previewState.descriptionController.text.isNotEmpty) {
      final video = VideoModel(
        id: uuid.v1(),
        description: previewState.descriptionController.text,
        videoUrl: previewState.widget.outputPath,
        user: UserInfoCubit.get(context).userEntity!,
        thumbnail: thumbnailFile?.path ?? '',
      );

      UploadVideosCubit.get(context)
          .uploadVideo(videoModel: video, sharedBy: null);
    } else {
      ToastHelper.showToast(message: 'Please add a description');
    }
  }

  // Private navigation methods
  static void _navigateToFavouritesPage({
    required BuildContext context,
    required UserEntity currentUser,
  }) {
    NavigationManager.navigateTo(
      context: context,
      screen: FavouritesScreen(currentUser: currentUser),
    );
  }

  static void _navigateToEditProfilePage({
    required BuildContext context,
  }) {
    NavigationManager.navigateTo(
      context: context,
      screen: const EditProfileScreen(),
    );
  }

  // static void pickImage({
  //   required BuildContext context,
  //   required EditProfileScreenState editState,
  // }) {
  //   editState.pickImage;
  // }

  static void _navigateToVideoPage(BuildContext context) {
    NavigationManager.navigateTo(
      context: context,
      screen: const VideosScreen(),
    );
  }

  static Future<void> _navigateToChooseVideoPage(BuildContext context) async {
    await UploadVideosCubit.get(context).pickVideo();
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
