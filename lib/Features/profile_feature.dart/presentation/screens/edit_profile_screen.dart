import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/domain/use_case/update_user_data_use_case.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/update_user_cubit/update_user_data_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/edit_profile_screen_body.dart';
import 'package:shorts/core/image_notifiere_controller/image_notifiere_controller.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/service_locator/service_locator.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/widgets/custom_progress_indicator.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_title.dart';
import '../widgets/update_profile_elevated_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  //final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late final ImageNotifierController imageNotifierController;

  @override
  void initState() {
    super.initState();
    imageNotifierController =
        ImageNotifierController(emailController: nameController);
    //  UserInfoCubit.get(context).getUserData();
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    phoneController.dispose();
    imageNotifierController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
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
      ),
    );
  }

  Widget _builder(BuildContext context, UserInfoState userState) {
    if (userState is GetUserInfoSuccessState) {
      nameController.text = userState.userEntity!.name;
      bioController.text = userState.userEntity!.bio;
      phoneController.text = userState.userEntity!.phone;
      imageNotifierController.profilePicNotifier.value =
          userState.userEntity!.profilePic;
    }

    return Scaffold(
      backgroundColor: ColorController.blackColor,
      appBar: const CustomAppBar(
        title: 'Edit Profile',
        backColor: ColorController.transparentColor,
        titleStyle: TitleStyle.styleBold24,
        centerTitle: true,
        showLeadingIcon: true,

        //leading: CustomBackIconWidget(),
      ),
      body: CustomProgressIndicator(
        isLoading: userState is GetUserInfoLoadingState,
        child: EditProfileScreenBody(state: this),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: UpdateProfileElevatedButton(
          editState: this,
        ),
      ),
    );
  }
}
