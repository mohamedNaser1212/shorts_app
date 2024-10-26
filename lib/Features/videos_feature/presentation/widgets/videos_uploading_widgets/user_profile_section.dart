import 'package:flutter/material.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/videos_profile_picture.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_contents_screen.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_list_tile.dart';

import '../../../../profile_feature.dart/presentation/screens/user_profile_screen.dart';

class UserProfileSection extends StatelessWidget {
  const UserProfileSection({
    super.key,
    required this.state,
  });

  final VideoContentsScreenState state;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 60,
      right: MediaQuery.of(context).size.width * 0.15,
      child: Column(
        children: [
          if (state.widget.videoEntity.sharedBy != null)
            InkWell(
              onTap: () {
                NavigationManager.navigateTo(
                  context: context,
                  screen: UserProfileScreen(
                    state: state,
                    isShared: true,
                  ),
                );
                print('Shared by: ${state.widget.videoEntity.sharedBy!.name}');
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.12,
                child: CustomListTile(
                  leading: UserProfilePicture(state: state),
                  title: state.widget.videoEntity.sharedBy!.name,
                  subtitle: state.widget.videoEntity.sharedUserDescription ?? '',
                  color: ColorController.whiteColor,
                ),
              ),
            ),
          const Divider(
            color: ColorController.whiteColor,
            thickness: 1,
          ),
          InkWell(
            onTap: () {
              NavigationManager.navigateTo(
                context: context,
                screen: UserProfileScreen(
                  state: state,
                  isShared: false,
                ),
              );
              print('Original user: ${state.widget.videoEntity.user.name}');
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.12,
              child: CustomListTile(
                leading: UserProfilePicture(state: state),
                title: state.widget.videoEntity.user.name,
                subtitle: state.widget.videoEntity.description,
                color: ColorController.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
