import 'package:flutter/material.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/screens/edit_profile_screen.dart';
import 'package:shorts/core/widgets/custom_elevated_botton.dart';

class ChangeProfilePictureElevatedBotton extends StatelessWidget {
  const ChangeProfilePictureElevatedBotton(
      {super.key, required this.editState});
  final EditProfileScreenState editState;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton.editProfileImagePickerButton(
      context: context,
      editState: editState,
    );
  }
}
