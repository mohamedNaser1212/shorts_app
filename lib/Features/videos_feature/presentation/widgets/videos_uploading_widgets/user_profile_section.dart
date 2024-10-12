import 'package:flutter/material.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/profile_picture.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_contents_screen.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
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
      child: InkWell(
        onTap: () {
          NavigationManager.navigateTo(
              context: context, screen: UserProfileScreen(state: state));
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.12,
          child: CustomListTile(
            leading: UserProfilePicture(state: state),
            title: state.widget.videoEntity.user.name,
            subtitle: state.widget.videoEntity.description,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
