import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shorts/core/functions/toast_function.dart';

class VideoNotifierController extends ChangeNotifier {
  final TextEditingController emailController;
  final ValueNotifier<File?> videoFileNotifier = ValueNotifier<File?>(null);

  VideoNotifierController({required this.emailController});

  // Pick video from either gallery or camera
  Future<void> pickVideo({required bool fromCamera}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile;

    if (fromCamera) {
      pickedFile = await picker.pickVideo(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      videoFileNotifier.value = File(pickedFile.path);
      notifyListeners(); // Notify listeners about the new video
    } else {
      // Handle when no video is selected
      ToastHelper.showToast(message: 'No video selected', color: Colors.red);
    }
  }

  @override
  void dispose() {
    videoFileNotifier.dispose();
    super.dispose();
  }
}
