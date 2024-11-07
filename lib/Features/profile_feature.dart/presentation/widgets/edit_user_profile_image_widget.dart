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
      onTap: () => _showImagePickerOptions(context),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ValueListenableBuilder<File?>(
            valueListenable:
                widget.editState?.imageNotifierController.imageFileNotifier ??
                    widget.registerFormState!.imageNotifierController
                        .imageFileNotifier,
            builder: (context, imageFile, child) {
              return ValueListenableBuilder<String?>(
                valueListenable: widget.editState?.imageNotifierController
                        .profilePicNotifier ??
                    widget.registerFormState!.imageNotifierController
                        .profilePicNotifier,
                builder: (context, profilePic, child) {
                  return CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 90,
                    backgroundImage: imageFile != null
                        ? FileImage(imageFile)
                        : profilePic != null
                            ? NetworkImage(profilePic)
                            : null,
                    child:
                        imageFile == null && profilePic == null ? null : null,
                  );
                },
              );
            },
          ),
          Positioned(
            bottom: 0,
            right: 10,
            child: GestureDetector(
              onTap: () => _showImagePickerOptions(context),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 24,
                child: Icon(
                  Icons.camera_alt,
                  size: 30,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Show modal sheet to select image source
  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take a photo"),
                onTap: () {
                  Navigator.pop(context);
                  widget.editState?.imageNotifierController
                      .pickImage(fromCamera: true);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text("Pick from gallery"),
                onTap: () {
                  Navigator.pop(context);
                  widget.editState?.imageNotifierController
                      .pickImage(fromCamera: false);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
