import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/update_user_cubit/update_user_data_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/edit_profile_screen_body.dart';
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
  String? profilePic;
    File? imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
  final formKey = GlobalKey<FormState>();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpdateUserDataCubit(),
        ),
      ],
      child: BlocBuilder<UserInfoCubit, UserInfoState>(
        builder: _builder,
      ),
    );
  }

  Widget _builder(context, userState) {
    if (userState is GetUserInfoSuccessState) {
      nameController.text = userState.userEntity!.name;
      emailController.text = userState.userEntity!.email;
      phoneController.text = userState.userEntity!.phone;
      profilePic = userState.userEntity!.profilePic;
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
