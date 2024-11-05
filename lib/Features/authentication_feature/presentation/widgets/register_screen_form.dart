import 'package:flutter/material.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/auth_status_text_widget.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/login_header.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_form_body.dart';
import 'package:shorts/core/image_notifiere_controller/image_notifiere_controller.dart';
import 'package:shorts/core/widgets/register_botton.dart';

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

  late final ImageNotifierController imageNotifierController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    bioController = TextEditingController();

    imageNotifierController =
        ImageNotifierController(emailController: emailController);
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    bioController.dispose();
    imageNotifierController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AuthHeader(
              title: 'Sign Up Now',
            ),
            const SizedBox(height: 15),
            RegisterFormBody(state: this),
            const SizedBox(height: 10),
            RegisterButton(state: this),
            const SizedBox(height: 10),
            AuthStatusTextWidget.register(context: context),
            const SizedBox(height: 10),
            // ValueListenableBuilder<File?>(
            //   valueListenable: imageNotifierController.imageFileNotifier,
            //   builder: (context, imageFile, child) {
            //     return imageFile != null
            //         ? Image.file(imageFile, height: 100, width: 100)
            //         : TextButton(
            //             onPressed: imageNotifierController.pickImage,
            //             child: const Text("Pick Image"),
            //           );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
