import 'dart:io';

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
  final phoneController = TextEditingController();
  final bioController = TextEditingController();
  late String imageUrl = '';
  late File imageFile = File('');
  final formKey = GlobalKey<FormState>();
  late final ImageNotifierController imageNotifierController;

  @override
  void initState() {
    super.initState();
    imageNotifierController = ImageNotifierController(
      emailController: nameController,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    bioController.dispose();
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
          builder: (context, userState) {
            return _buildScreen(
              context,
              userState,
            );
          },
        ),
      ),
    );
  }

  Widget _buildScreen(
    BuildContext context,
    UserInfoState userState,
  ) {
    final isLoading = userState is GetUserInfoLoadingState;
    if (userState is GetUserInfoSuccessState) {
      nameController.text = userState.userEntity!.name;
      bioController.text = userState.userEntity!.bio;
      phoneController.text = userState.userEntity!.phone;
      imageUrl = userState.userEntity!.profilePic;
    }
    return BlocBuilder<UpdateUserDataCubit, UpdateUserDataState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorController.blackColor,
          appBar: const CustomAppBar(
            title: 'Edit Profile',
            backColor: ColorController.transparentColor,
            titleStyle: TitleStyle.styleBold24,
            centerTitle: true,
            showLeadingIcon: true,
          ),
          body: BlockInternactionLoadingWidget(
            isLoading: isLoading || state is UpdateUserDataLoadingState,
            child: CustomScrollView(
              scrollBehavior: const MaterialScrollBehavior(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: EditProfileScreenBody(state: this),
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      UpdateProfileElevatedButton(editState: this),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
