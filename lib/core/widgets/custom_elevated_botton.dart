import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/login_screen_body.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_screen_form.dart';
import 'package:shorts/Features/favourites_feature/presentation/screens/favourites_screen.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/Features/videos_feature/presentation/screens/video_screen.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/upload_videos_cubit/upload_videos_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/preview_screen.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/functions/toast_function.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
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
  CustomElevatedButton({
    required this.onPressed,
    required this.label,
    this.backColor,
  });

  final VoidCallback onPressed;
  final String label;
  Color? backColor;

  factory CustomElevatedButton.loginButton({
    required LoginScreenBodyState state,
    required BuildContext context,
  }) {
    return CustomElevatedButton(
      onPressed: () => _loginAction(state, context),
      label: 'Login',
    );
  }

  factory CustomElevatedButton.registerButton({
    required BuildContext context,
    required RegisterScreenFormState state,
  }) {
    return CustomElevatedButton(
      onPressed: () => _registerAction(context, state),
      label: 'Register',
    );
  }
  factory CustomElevatedButton.editProfileButton({
    required BuildContext context,
    required EditProfileScreenState state,
  }) {
    return CustomElevatedButton(
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
    return CustomElevatedButton(
      onPressed: () => _signOutOnPressed(context: context),
      label: 'Sign Out',
    );
  }

  factory CustomElevatedButton.favouritesPageButton({
    required BuildContext context,
  }) {
    return CustomElevatedButton(
      onPressed: () => _navigateToFavouritesPage(
        context: context,
      ),
      label: 'Favourites',
    );
  }
  factory CustomElevatedButton.editProfilePage({
    required BuildContext context,
  }) {
    return CustomElevatedButton(
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
    return CustomElevatedButton(
      label: 'Change Profile Picture',
      onPressed: () {},
    );
  }

  factory CustomElevatedButton.uploadVideo({
    required BuildContext context,
    required PreviewScreenState previewState,
    required File? thumbnailFile,
  }) {
    return CustomElevatedButton(
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
    return CustomElevatedButton(
      onPressed: () => _navigateToVideoPage(context),
      label: 'Videos',
    );
  }

  factory CustomElevatedButton.chooseVideoPageButton({
    required BuildContext context,
  }) {
    return CustomElevatedButton(
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

  static Future<void> _editProfileButtonOnPressed({
    required BuildContext context,
    required EditProfileScreenState editState,
  }) async {
    // final cubit = UpdateUserDataCubit.get(context);
    final userCubit = UserInfoCubit.get(context);

    // Get the current user data
    final currentUser = userCubit.userEntity;

    // Collect updates for fields that have changed
    final updates = <String, dynamic>{};

    // if (currentUser!.email != editState.emailController.text) {
    //   updates['email'] = editState.emailController.text;
    // }
    if (currentUser!.name != editState.nameController.text) {
      updates['name'] = editState.nameController.text;
    }

    if (currentUser.bio != editState.bioController.text) {
      updates['bio'] = editState.bioController.text;
    }

    // if (editState.imageNotifierController.imageFileNotifier.value != null) {
    //   final newImageUrl = await editState.imageNotifierController.uploadImage();
    //   if (newImageUrl != null && currentUser.profilePic != newImageUrl) {
    //     updates['profilePic'] = newImageUrl;
    //   }
    // }

    // if (updates.isNotEmpty) {
    //   cubit.updateUserData(
    //     updateUserRequestModel: UpdateUserRequestModel(
    //       // email: updates['email'] ?? currentUser.email,
    //       name: updates['name'] ?? currentUser.name,
    //       phone: updates['phone'] ?? currentUser.phone,
    //       imageUrl: updates['profilePic'] ?? currentUser.profilePic,
    //       bio: updates['bio'] ?? currentUser.bio,
    //     ),
    //     imageFile: editState.imageNotifierController.imageFileNotifier.value!,
    //     userId: currentUser.id!,
    //   );
    // }
  }

  static Future<void> _registerAction(
      BuildContext context, RegisterScreenFormState state) async {
    if (state.widget.formKey.currentState!.validate()) {
      // Check if an image is selected and attempt to upload it
      final profilePicUrl = await state.imageNotifierController.uploadImage();
      if (profilePicUrl != null) {
        // Set the profile picture URL in the registration model only if upload was successful
        RegisterCubit.get(context).userRegister(
          requestModel: RegisterRequestModel(
            email: state.emailController.text,
            password: state.passwordController.text,
            name: state.nameController.text,
            phone: state.phoneController.text,
            bio: state.bioController.text.isNotEmpty
                ? state.bioController.text
                : 'Hey there I am using Shorts',
            profilePic: profilePicUrl,
          ),
          imageFile: state.imageFile,
        );
      } else {
        ToastHelper.showToast(
          message: 'Image upload failed. Please try again.',
          color: Colors.red,
        );
      }
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

      UploadVideosCubit.get(context).uploadVideo(
        videoModel: video,
      );
    } else {
      ToastHelper.showToast(message: 'Please add a description');
    }
  }

  // Private navigation methods
  static void _navigateToFavouritesPage({
    required BuildContext context,
  }) {
    NavigationManager.navigateTo(
      context: context,
      screen: const FavouritesScreen(),
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
      backColor: ColorController.purpleColor,
      onPressed: onPressed,
    );
  }
}
