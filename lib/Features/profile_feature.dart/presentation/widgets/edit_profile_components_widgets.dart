import 'package:flutter/material.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/update_profile_elevated_button.dart';

import '../../../../core/widgets/custom_progress_indicator.dart';
import '../cubit/update_user_cubit/update_user_data_cubit.dart';
import '../screens/edit_profile_screen.dart';
import 'edit_profile_screen_body.dart';

class EditProfileComponentsWidgets extends StatelessWidget {
  const EditProfileComponentsWidgets({
    super.key,
    required this.isLoading,
    required this.state,
    required this.editProfileScreenState,
  });

  final bool isLoading;
  final UpdateUserDataState state;
  final EditProfileScreenState editProfileScreenState;

  @override
  Widget build(BuildContext context) {
    return BlockInteractionLoadingWidget(
      isLoading: isLoading || state is UpdateUserDataLoadingState,
      child: CustomScrollView(
        scrollBehavior: const MaterialScrollBehavior(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: editProfileScreenState.formKey,
                child: EditProfileScreenBody(state: editProfileScreenState),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                UpdateProfileElevatedButton(editState: editProfileScreenState),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
