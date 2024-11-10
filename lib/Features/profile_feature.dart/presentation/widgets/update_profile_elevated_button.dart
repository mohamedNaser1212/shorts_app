import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/update_user_cubit/update_user_data_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/screens/edit_profile_screen.dart';
import 'package:shorts/core/widgets/loading_indicator.dart';

import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/user_info/cubit/user_info_cubit.dart';
import '../../../../core/widgets/reusable_elevated_botton.dart';
import '../../domain/models/update_request_model.dart';

class UpdateProfileElevatedButton extends StatelessWidget {
  const UpdateProfileElevatedButton({super.key, required this.editState});
  final EditProfileScreenState editState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateUserDataCubit, UpdateUserDataState>(
      builder: (context, state) {
        bool isLoading = state is UpdateUserDataLoadingState;

        return ConditionalBuilder(
          condition: !isLoading,
          builder: (context) => ReusableElevatedButton(
            onPressed: () => _onPressed(context: context),
            backColor: ColorController.purpleColor,
            label: 'Edit',
          ),
          fallback: (context) => const LoadingIndicatorWidget(),
        );
      },
    );
  }

  void _onPressed({
    required BuildContext context,
  }) async {
    final cubit = UpdateUserDataCubit.get(context);
    final userCubit = UserInfoCubit.get(context);

    final currentUser = userCubit.userEntity;

    final updates = <String, dynamic>{};

    // if (currentUser!.email != editState.emailController.text) {
    //   updates['email'] = editState.emailController.text;
    // }
    if (currentUser!.name != editState.nameController.text) {
      updates['name'] = editState.nameController.text;
    }
    if (currentUser.phone != editState.phoneController.text) {
      updates['phone'] = editState.phoneController.text;
    }
    if (currentUser.bio != editState.bioController.text) {
      updates['bio'] = editState.bioController.text;
    }

    if (editState.imageNotifierController.imageFileNotifier.value != null) {
      final newImageUrl = await editState.imageNotifierController.uploadImage();
      if (newImageUrl != null && currentUser.profilePic != newImageUrl) {
        updates['profilePic'] = newImageUrl;
      }
    }

    if (updates.isNotEmpty) {
      cubit.updateUserData(
        updateUserRequestModel: UpdateUserRequestModel(
          name: updates['name'] ?? currentUser.name,
          phone: updates['phone'] ?? currentUser.phone,
          bio: updates['bio'] ?? currentUser.bio,
          imageUrl: updates['profilePic'] ?? currentUser.profilePic,
        ),
        userId: currentUser.id!,
      );
    }
  }
}
