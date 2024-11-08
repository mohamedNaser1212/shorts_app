import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/get_user_videos_state.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/screens/user_profile_screen.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/profile_actions.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_image_widget.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_video_grid_view.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';
import 'package:shorts/core/widgets/custom_title.dart';

import 'custom_user_profile_information_widget.dart';

class UserProfileScreenBody extends StatefulWidget {
  const UserProfileScreenBody({
    super.key,
    this.videoEntity,
    required this.userProfileState,
    this.comment,
    this.userEntity,
  });
  final VideoEntity? videoEntity;
  final UserEntity? userEntity;
  final UserProfileScreenState userProfileState;
  final CommentEntity? comment;

  @override
  State<UserProfileScreenBody> createState() => UserProfileScreenBodyState();
}

class UserProfileScreenBodyState extends State<UserProfileScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const CustomAppBar(title: 'User Profile'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: BlocBuilder<GetUserVideosCubit, UserProfileState>(
          builder: (context, state) {
            if (state is GetUserVideosLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final user = widget.userProfileState.widget.user ??
                widget.comment?.user ??
                widget.videoEntity?.user ??
                widget.userEntity;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserProfileImageWidget(
                  videoEntity: widget.videoEntity,
                  comment: widget.comment,
                  user: user,
                ),
                const SizedBox(height: 40),
                CustomTitle(
                  title: widget.comment?.user.name ??
                      widget.videoEntity?.user.name ??
                      widget.userProfileState.widget.user?.name ??
                      widget.videoEntity?.sharedBy?.name ??
                      widget.userEntity!.name,
                  style: TitleStyle.style16,
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomUserProfileInformations(
                      number: '0',
                      title: 'Followings',
                    ),
                    CustomUserProfileInformations(
                      number: '0',
                      title: 'Followers',
                    ),
                    CustomUserProfileInformations(
                      number: '0',
                      title: 'likes',
                    ),
                  ],
                ),
                const ProfileActions(),
                const SizedBox(height: 10),
                const CustomTitle(
                  title: 'Videos',
                  style: TitleStyle.style16,
                ),
                const SizedBox(height: 10),
                UserProfileVideosGridView(
                  state: this,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
