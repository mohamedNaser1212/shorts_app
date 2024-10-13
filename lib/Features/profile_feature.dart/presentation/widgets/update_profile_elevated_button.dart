import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/update_user_cubit/update_user_data_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/screens/edit_profile_screen.dart';
import 'package:shorts/core/widgets/custom_elevated_botton.dart';
import 'package:shorts/core/widgets/loading_indicator.dart';

class UpdateProfileElevatedButton extends StatelessWidget {
  const UpdateProfileElevatedButton({super.key, required this.editState, required this.state});
  final EditProfileScreenState editState;
  final UpdateUserDataState state;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: state is! UpdateUserDataLoadingState,
      builder:(context) =>  CustomElevatedButton.editProfileButton(
        context: context,
        state: editState,
      ),
      fallback: (context) => const LoadingIndicatorWidget(),
    );
  }
}
