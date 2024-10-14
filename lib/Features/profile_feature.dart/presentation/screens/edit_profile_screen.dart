import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/domain/use_case/update_user_data_use_case.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/update_user_cubit/update_user_data_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/edit_profile_screen_body.dart';
import 'package:shorts/core/functions/toast_function.dart';
import 'package:shorts/core/managers/image_picker_manager/image_picker_manager.dart';
import 'package:shorts/core/service_locator/service_locator.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/widgets/custom_progress_indicator.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final ValueNotifier<File?> imageFileNotifier = ValueNotifier<File?>(null);
  final ValueNotifier<String?> profilePicNotifier = ValueNotifier<String?>(null);

  Future<void> pickImage() async {
    final pickedFile = await ImagePickerHelper.pickImageFromGallery();
    if (pickedFile != null) {
      imageFileNotifier.value = pickedFile;
      await uploadImage();
    }
  }

  Future<void> uploadImage() async {
    if (imageFileNotifier.value == null) return;

    String fileName = 'profile_images/${emailController.text}.jpg';
    final uploadedProfilePic = await ImagePickerHelper.uploadImage(imageFileNotifier.value!, fileName);
    
    profilePicNotifier.value = uploadedProfilePic;
    ToastHelper.showToast(
      message: 'Image uploaded successfully',
      color: Colors.green,
    );
  }

  @override
  void initState() {
    super.initState();
    UserInfoCubit.get(context).getUserData();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    imageFileNotifier.dispose();
    profilePicNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpdateUserDataCubit(
            updateUserDataUseCase: getIt.get<UpdateUserDataUseCase>(),
          ),
        ),
      ],
      child: BlocBuilder<UserInfoCubit, UserInfoState>(
        builder: _builder,
      ),
    );
  }

  Widget _builder(BuildContext context, UserInfoState userState) {
    if (userState is GetUserInfoSuccessState) {
      nameController.text = userState.userEntity!.name;
      emailController.text = userState.userEntity!.email;
      phoneController.text = userState.userEntity!.phone;
      profilePicNotifier.value == userState.userEntity!.profilePic;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: CustomProgressIndicator(
        isLoading: userState is GetUserInfoLoadingState,
        child: EditProfileScreenBody(state: this),
      ),
    );
  }


}
