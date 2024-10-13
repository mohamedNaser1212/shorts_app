import 'package:flutter/material.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/auth_status_text_widget.dart';
import 'package:shorts/core/widgets/register_botton.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_form.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_header.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  
  File? imageFile;
  final ImagePicker _picker = ImagePicker();

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
  }

  String? profilePic;


  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      await uploadImage();
    }
  }

  Future<void> uploadImage() async {
    if (imageFile == null) return;

    try {
      String fileName = 'profile_images/${emailController.text}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageRef = FirebaseStorage.instance.ref().child(fileName);

      UploadTask uploadTask = storageRef.putFile(imageFile!);
      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        profilePic = downloadUrl;  
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
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
