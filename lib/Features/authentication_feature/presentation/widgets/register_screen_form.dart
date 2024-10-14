import 'package:flutter/material.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/auth_status_text_widget.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_form_body.dart';
import 'package:shorts/core/managers/image_picker_manager/image_picker_manager.dart';
import 'package:shorts/core/widgets/register_botton.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_header.dart';
import 'dart:io';

class RegisterScreenForm extends StatefulWidget {
  const RegisterScreenForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  State<RegisterScreenForm> createState() => RegisterScreenFormState();
}

class RegisterScreenFormState extends State<RegisterScreenForm> {
  late final TextEditingController emailController;
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  late final TextEditingController bioController;

  final ValueNotifier<File?> imageFileNotifier = ValueNotifier(null);
  final ValueNotifier<String?> imageUrlNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    bioController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    bioController.dispose();
    imageFileNotifier.dispose();
    imageUrlNotifier.dispose();
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePickerHelper.pickImageFromGallery();
    if (pickedFile != null) {
      imageFileNotifier.value = pickedFile;
     // await uploadImage();
    }
  }

  Future<void> uploadImage() async {
    if (imageFileNotifier.value == null) return;

    String fileName = 'profile_images/${emailController.text}.jpg';
    imageUrlNotifier.value = await ImagePickerHelper.uploadImage(imageFileNotifier.value!, fileName);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const RegisterHeader(),
          const SizedBox(height: 15),
          RegisterFormBody(state: this),
          const SizedBox(height: 10),
          RegisterButton(state: this),
          const SizedBox(height: 10),
          AuthStatusTextWidget.register(context: context),
        ],
      ),
    );
  }
}
