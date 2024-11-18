import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_screen_form.dart';

import '../../../../core/functions/toast_function.dart';
import '../../../../core/widgets/custom_container_widget.dart';
import '../screens/edit_profile_screen.dart';

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
      onTap: () => _showImagePickerOptions(context: context),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 90,
            backgroundImage: _getImageProvider(),
          ),
          Positioned(
            bottom: 0,
            right: 10,
            child: GestureDetector(
              onTap: () => _showImagePickerOptions(context: context),
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

  ImageProvider _getImageProvider() {
    final profilePic =
        widget.editState?.imageUrl ?? widget.registerFormState!.imageUrl;
    if (profilePic.isNotEmpty) {
      return profilePic.startsWith('http')
          ? CachedNetworkImageProvider(profilePic)
          : FileImage(File(profilePic)) as ImageProvider;
    }
    return const AssetImage('assets/images/grey.jpg');
  }

  void _showImagePickerOptions({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomContainerWidget(
                title: "Take a photo",
                icon: Icons.camera_alt,
                onTap: () {
                  Navigator.pop(context);
                  pickImage(fromCamera: true);
                },
              ),
              const SizedBox(height: 10),
              CustomContainerWidget(
                title: "Pick from gallery",
                icon: Icons.image,
                onTap: () {
                  Navigator.pop(context);
                  pickImage(fromCamera: false);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickImage({required bool fromCamera}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile;

    if (fromCamera) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      widget.editState?.imageFile = File(pickedFile.path);
      widget.editState?.imageUrl = pickedFile.path;
      widget.registerFormState?.imageUrl = pickedFile.path;
      setState(() {});
    } else {
      ToastHelper.showToast(message: 'No image selected', color: Colors.red);
    }
  }
}
