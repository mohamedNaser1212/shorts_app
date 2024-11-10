import 'package:flutter/material.dart';

import 'custom_user_profile_information_widget.dart';

class UserProfileInformationsWidgets extends StatelessWidget {
  const UserProfileInformationsWidgets({
    super.key,
    required this.number,
    required this.title,
  });
  final int number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomUserProfileInformations(number: number, title: title);
  }
}
