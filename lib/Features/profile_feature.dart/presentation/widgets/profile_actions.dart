import 'package:flutter/material.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/user_info/cubit/user_info_cubit.dart';
import '../../../../core/widgets/custom_container_widget.dart';
import '../../../../core/widgets/custom_title.dart';
import '../screens/edit_profile_screen.dart';

class ProfileActions extends StatelessWidget {
  const ProfileActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: CustomContainerWidget(
              title: 'Edit Profile',
              titleStyle: TitleStyle.styleBold18,
              onTap: () {
                NavigationManager.navigateTo(
                  context: context,
                  screen: const EditProfileScreen(),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: CustomContainerWidget(
              titleStyle: TitleStyle.styleBold18,
              title: 'Log Out',
              // icon: Icons.exit_to_app,
              containerColor: ColorController.redColor,
              onTap: () {
                UserInfoCubit.get(context).signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
