import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_screen_form.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/screens/edit_profile_screen.dart';

class EditUserProfileImageWidget extends StatefulWidget {
  const EditUserProfileImageWidget({
    super.key,
    this.editState,
    this.registerFormState,
  });

  final EditProfileScreenState? editState;
  final RegisterScreenFormState? registerFormState;

  @override
  State<EditUserProfileImageWidget> createState() =>
      EditUserProfileImageWidgetState();
}

class EditUserProfileImageWidgetState
    extends State<EditUserProfileImageWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.editState != null) {
          widget.editState?.imageNotifierController.pickImage();
        } else {
          widget.registerFormState?.imageNotifierController.pickImage();
        }
      },
      child: ValueListenableBuilder<File?>(
        valueListenable:  widget.editState?.imageNotifierController.imageFileNotifier ??  widget.registerFormState!.imageNotifierController.imageFileNotifier,
        builder: (context, imageFile, child) {
          return ValueListenableBuilder<String?>(
            valueListenable:  widget.editState?.imageNotifierController.profilePicNotifier ??  widget.registerFormState!.imageNotifierController.profilePicNotifier,
            builder: (context, profilePic, child) {
              return CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 120,
                backgroundImage: imageFile != null
                    ? FileImage(imageFile)
                    : profilePic != null
                        ? NetworkImage(profilePic)
                        : null,
                child: imageFile == null && profilePic == null
                    ? const Icon(Icons.camera_alt, size: 50, color: Colors.white)
                    : null,
              );
            },
          );
        },
      ),
    );
  }
}
