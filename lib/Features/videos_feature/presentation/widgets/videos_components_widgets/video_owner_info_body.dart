import 'package:flutter/material.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/screens/user_profile_screen.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/videos_profile_picture.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_contents_screen.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_read_more_widget.dart';
import 'package:shorts/core/widgets/custom_title.dart';

class VideoOwnerInfoBody extends StatelessWidget {
  const VideoOwnerInfoBody({
    super.key,
    required this.userName,
    required this.description,
    required this.state,
  });

  final String userName;
  final String description;
  final VideoContentsScreenState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
            onTap: () {
              if (state.widget.videoEntity.sharedBy != null) {
                NavigationManager.navigateTo(
                  context: context,
                  screen: UserProfileScreen(
                    user: state.widget.videoEntity.sharedBy,
                    isShared: true,
                  ),
                );
              } else {
                NavigationManager.navigateTo(
                  context: context,
                  screen: UserProfileScreen(
                    videoEntity: state.widget.videoEntity,
                    isShared: false,
                  ),
                );
              }

              print('Original user: ${state.widget.videoEntity.user.name}');
            },
            child: UserProfilePicture(state: state)),
        const SizedBox(
          width: 20,
          height: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(
                title: userName,
                style: TitleStyle.style16,
                color: ColorController.whiteColor,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomReadMoreWidget(
                text: description,
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }
}