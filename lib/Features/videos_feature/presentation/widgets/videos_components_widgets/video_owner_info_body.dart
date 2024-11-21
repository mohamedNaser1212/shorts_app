import 'package:flutter/material.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/screens/user_profile_screen.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/videos_profile_picture.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_contents_screen.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_owner_name_and_follow_text.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/widgets/custom_read_more_widget.dart';

import '../../../../../core/user_info/cubit/user_info_cubit.dart';
import '../../../../profile_feature.dart/presentation/cubit/follow_cubit/follow_cubit.dart';

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
          onTap: () => _onTap(context: context, state: state),
          child: UserProfilePicture(state: state),
        ),
        const SizedBox(
          width: 20,
          height: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VideoOwnerNameWidget(
                userName: userName,
                state: state,
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

  Future<void> _onTap({
    required BuildContext context,
    required VideoContentsScreenState state,
  }) async {
    FollowCubit.get(context).isUserFollowed(
      currentUserId: UserInfoCubit.get(context).userEntity!.id!,
      targetUserId: state.widget.videoEntity.user.id!,
    );

    NavigationManager.navigateTo(
      context: context,
      screen: UserProfileScreen(
        user: state.widget.videoEntity.user,
        // videoEntity: state.widget.videoEntity,
        // isShared: false,
      ),
    );
  }
}
