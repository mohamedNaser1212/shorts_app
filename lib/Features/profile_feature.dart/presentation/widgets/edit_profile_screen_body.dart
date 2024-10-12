import 'package:flutter/material.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/screens/edit_profile_screen.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/edit_profile_form.dart';

class EditProfileScreenBody extends StatelessWidget {
  const EditProfileScreenBody({super.key, required this.state});
final EditProfileScreenState state;
  @override
  Widget build(BuildContext context) {
    return EditProfileForm(
      state: state,
    );
  }
}