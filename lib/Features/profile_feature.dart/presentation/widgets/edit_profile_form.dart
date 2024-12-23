import 'package:flutter/material.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/screens/edit_profile_screen.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/settings_form_body.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({super.key, required this.state});
  final EditProfileScreenState state;

  @override
  Widget build(BuildContext context) {
    return SettingsFormBody(
      editState: state,
    );
  }
}
