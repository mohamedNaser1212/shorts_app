import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shorts/core/functions/toast_function.dart';
import 'package:shorts/core/managers/image_picker_manager/image_picker_manager.dart';

class ImageNotifierController extends ChangeNotifier {
  final TextEditingController emailController;
  final ValueNotifier<File?> imageFileNotifier = ValueNotifier<File?>(null);
  final ValueNotifier<String?> profilePicNotifier =
      ValueNotifier<String?>(null);

  ImageNotifierController({required this.emailController});

  Future<void> pickImage({required bool fromCamera}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile;

    if (fromCamera) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      imageFileNotifier.value = File(pickedFile.path);
      notifyListeners(); // Notify listeners about the new image
    } else {
      // Handle when no image is selected
      ToastHelper.showToast(message: 'No image selected', color: Colors.red);
    }
  }

  Future<String?> uploadImage() async {
    if (imageFileNotifier.value == null) return null;

    String fileName = 'profile_images/${emailController.text}.jpg';
    try {
      final uploadedProfilePic = await ImagePickerHelper.uploadImage(
        imageFileNotifier.value!,
        fileName,
      );
      profilePicNotifier.value = uploadedProfilePic;
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
