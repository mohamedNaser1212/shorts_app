import 'package:flutter/material.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/register_screen_form.dart';
import 'package:shorts/core/widgets/reusable_elevated_botton.dart';

import '../../Features/authentication_feature/data/user_model/register_request_model.dart';
import '../../Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import '../functions/toast_function.dart';
import '../managers/styles_manager/color_manager.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
    required this.state,
  });

  final RegisterScreenFormState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReusableElevatedButton(
          onPressed: () => _registerAction(
            context: context,
            state: state,
          ),
          label: 'Sign Up',
          backColor: ColorController.purpleColor,
        ),
        // CustomElevatedButton.loginButton(
        //   state: state,
        //   context: context,
        //
        //
        // ),
      ],
    );
  }

  Future<void> _registerAction({
    required BuildContext context,
    required RegisterScreenFormState state,
  }) async {
    if (state.widget.formKey.currentState!.validate()) {
      final profilePicUrl = await state.imageNotifierController.uploadImage();

      RegisterCubit.get(context).userRegister(
        requestModel: RegisterRequestModel(
          email: state.emailController.text,
          password: state.passwordController.text,
          name: state.nameController.text,
          phone: state.phoneController.text,
          bio: state.bioController.text.isNotEmpty
              ? state.bioController.text
              : 'Hey there I am using Shorts',
          profilePic: profilePicUrl ?? "",
        ),
      );
    } else {
      ToastHelper.showToast(
        message: 'Image upload failed. Please try again.',
        color: Colors.red,
      );
    }
  }
  //}
}
