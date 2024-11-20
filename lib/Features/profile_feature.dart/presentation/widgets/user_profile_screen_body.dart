import 'package:flutter/material.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/profile_actions.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/profile_screen_counts.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_image_widget.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_video_grid_view.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/widgets/custom_title.dart';

import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import 'follow_elevated_button_widget.dart';

class UserProfileScreenBody extends StatefulWidget {
  const UserProfileScreenBody({
    super.key,
    this.userEntity,
  });

  final UserEntity? userEntity;

  @override
  State<UserProfileScreenBody> createState() => UserProfileScreenBodyState();
}

class UserProfileScreenBodyState extends State<UserProfileScreenBody> {
  @override
  Widget build(BuildContext context) {
    String name = widget.userEntity!.name;
    return Scaffold(
      backgroundColor: ColorController.blackColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
            UserProfileImageWidget(
              user: widget.userEntity!,
            ),
            const SizedBox(height: 10),
            CustomTitle(title: name, style: TitleStyle.styleBold24),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FollowingFollowersCountWidget(
                  userEntity: widget.userEntity!,
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (widget.userEntity!.id ==
                UserInfoCubit.get(context).userEntity!.id)
              const ProfileActions()
            else
              FollowElevatedButtonWidget(
                currentUserId: UserInfoCubit.get(context).userEntity!.id!,
                targetUserId: widget.userEntity!.id!,
              ),
            const SizedBox(height: 10),
            UserProfileVideosGridView(state: this),
          ],
        ),
      ),
    );
  }
}
