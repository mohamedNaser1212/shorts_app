import 'package:flutter/material.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/user_info/cubit/user_info_cubit.dart';
import '../../../../core/widgets/custom_container_widget.dart';
import '../screens/edit_profile_screen.dart';

class ProfileActions extends StatelessWidget {
  const ProfileActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween, // space between the containers
      children: [
        Expanded(
          child: CustomContainerWidget(
            title: 'Edit Profile',
            icon: Icons.edit,
            onTap: () {
              // Navigate to EditProfileScreen
              NavigationManager.navigateTo(
                context: context,
                screen: const EditProfileScreen(),
              );
            },
          ),
        ),
        const SizedBox(width: 10), // gap between the two containers
        Expanded(
          child: CustomContainerWidget(
            title: 'Log Out',
            icon: Icons.exit_to_app, // You can use a logout icon here
            onTap: () {
              // Call sign out method
              UserInfoCubit.get(context).signOut();
            },
          ),
        ),
      ],
    );
  }
}
