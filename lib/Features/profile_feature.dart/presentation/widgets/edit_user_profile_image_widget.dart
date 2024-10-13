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
          widget.editState?.pickImage();
        } else {
          widget.registerFormState?.pickImage();
        }
      },
      child: ValueListenableBuilder<File?>(
        valueListenable: widget.editState?.imageFileNotifier ?? ValueNotifier<File?>(null),
        builder: (context, imageFile, child) {
          return ValueListenableBuilder<String?>(
            valueListenable: widget.editState?.profilePicNotifier ?? ValueNotifier<String?>(null),
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
