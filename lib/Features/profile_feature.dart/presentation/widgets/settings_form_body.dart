import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/authentication_feature/presentation/widgets/name_text_field.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/update_user_cubit/update_user_data_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/screens/edit_profile_screen.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/change_profile_picture_elevated_botton.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/edit_user_profile_image_widget.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/sign_out_elevated_button.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/update_profile_elevated_button.dart';
import 'package:shorts/core/functions/toast_function.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/widgets/email_text_field.dart';
import 'package:shorts/core/widgets/phone_text_field.dart';

class SettingsFormBody extends StatefulWidget {
  const SettingsFormBody({super.key, required this.editState});
  final EditProfileScreenState editState;

  @override
  State<SettingsFormBody> createState() => _SettingsFormBodyState();
}

class _SettingsFormBodyState extends State<SettingsFormBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateUserDataCubit, UpdateUserDataState>(
      listener: _updateListener,
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, UpdateUserDataState state) {
    return Column(
      children: [
        EditUserProfileImageWidget(editState: widget.editState),
        const SizedBox(height: 20.0),
        ChangeProfilePictureElevatedBotton(editState: widget.editState),
        const SizedBox(height: 20.0),
        NameField(controller: widget.editState.nameController),
        const SizedBox(height: 20.0),
        EmailField(controller: widget.editState.emailController),
        const SizedBox(height: 20.0),
        PhoneField(controller: widget.editState.phoneController),
        const SizedBox(height: 20.0),
        UpdateProfileElevatedButton(editState: widget.editState),
        const SizedBox(height: 20.0),
        SignOutElevatedButton(editState: widget.editState),
      ],
    );
  }

  void _updateListener(BuildContext context, UpdateUserDataState state) {
    if (state is UpdateUserDataErrorState) {
      ToastHelper.showToast(
        message: state.message,
        color: ColorController.redAccent,
      );
    } else if (state is UpdateUserDataSuccessState) {
      UserInfoCubit.get(context).getUserData();
      ToastHelper.showToast(
        message: 'Data updated successfully',
        color: ColorController.greenAccent,
      );
    }
  }
}
