import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shorts/core/functions/toast_function.dart';
import 'package:shorts/core/managers/image_picker_manager/image_picker_manager.dart';

class ImageNotifierController extends ChangeNotifier {
  final TextEditingController emailController;
  final ValueNotifier<File?> imageFileNotifier = ValueNotifier<File?>(null);
  final ValueNotifier<String?> profilePicNotifier =
      ValueNotifier<String?>(null);

  ImageNotifierController({required this.emailController});

  Future<void> pickImage() async {
    final pickedFile = await ImagePickerHelper.pickImageFromGallery();
    if (pickedFile != null) {
      imageFileNotifier.value = pickedFile;
      notifyListeners(); // Notify listeners that an image has been picked
    }
  }

  Future<String?> uploadImage() async {
    if (imageFileNotifier.value == null) return null;

    String fileName = 'profile_images/${emailController.text}.jpg';
    try {
      final uploadedProfilePic = await ImagePickerHelper.uploadImage(
          imageFileNotifier.value!, fileName);
      profilePicNotifier.value = uploadedProfilePic;
      // ToastHelper.showToast(
      //   message: 'Image uploaded successfully',
      //   color: Colors.green,
      // );
      return uploadedProfilePic;
    } catch (e) {
      ToastHelper.showToast(
        message: 'Image upload failed',
        color: Colors.red,
      );
      return null;
    }
  }

  @override
  void dispose() {
    imageFileNotifier.dispose();
    profilePicNotifier.dispose();
    super.dispose();
  }
}
