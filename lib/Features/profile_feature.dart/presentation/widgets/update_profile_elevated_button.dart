import 'package:flutter/material.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/update_user_cubit/update_user_data_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/screens/edit_profile_screen.dart';

import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/user_info/cubit/user_info_cubit.dart';
import '../../../../core/utils/constants/request_data_names.dart';
import '../../../../core/widgets/reusable_elevated_botton.dart';
import '../../domain/models/update_request_model.dart';

class UpdateProfileElevatedButton extends StatelessWidget {
  const UpdateProfileElevatedButton({super.key, required this.editState});
  final EditProfileScreenState editState;

  @override
  Widget build(BuildContext context) {
    return ReusableElevatedButton(
      onPressed: () => _onPressed(context: context),
      backColor: ColorController.purpleColor,
      label: 'Edit',
    );
  }

  void _onPressed({
    required BuildContext context,
  }) async {
    final cubit = UpdateUserDataCubit.get(context);
    final userCubit = UserInfoCubit.get(context);

    final currentUser = userCubit.userEntity;

    final updates = <String, dynamic>{};

    // Update other fields if changed
    if (currentUser!.name != editState.nameController.text) {
      updates[RequestDataNames.name] = editState.nameController.text;
    }
    if (currentUser.phone != editState.phoneController.text) {
      updates[RequestDataNames.phone] = editState.phoneController.text;
    }
    if (currentUser.bio != editState.bioController.text) {
      updates[RequestDataNames.bio] = editState.bioController.text;
    }

    // Only update the image if a new image is provided

    if (currentUser.profilePic != editState.imageUrl) {
      updates[RequestDataNames.profilePic] = editState.imageUrl;
    }

    if (updates.isNotEmpty) {
      cubit.updateUserData(
        updateUserRequestModel: UpdateUserRequestModel(
          name: updates[RequestDataNames.name] ?? currentUser.name,
          phone: updates[RequestDataNames.phone] ?? currentUser.phone,
          bio: updates[RequestDataNames.bio] ?? currentUser.bio,
          imageUrl:
              updates[RequestDataNames.profilePic] ?? currentUser.profilePic,
        ),
        imageFile: editState.imageFile,
        userId: currentUser.id!,
      );
    }
  }
}
