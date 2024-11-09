import 'package:flutter/material.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/profile_actions.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_image_widget.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_video_grid_view.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/widgets/custom_title.dart';

import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import 'custom_user_profile_information_widget.dart';

class UserProfileScreenBody extends StatefulWidget {
  const UserProfileScreenBody({
    super.key,
    // this.videoEntity,
    // required this.userProfileState,
    // this.comment,
    this.userEntity,
    // this.userId,
  });
//  final String? userId;
  // final VideoEntity? videoEntity;
  final UserEntity? userEntity;
  // final UserProfileScreenState userProfileState;
  // final CommentEntity? comment;

  @override
  State<UserProfileScreenBody> createState() => UserProfileScreenBodyState();
}

class UserProfileScreenBodyState extends State<UserProfileScreenBody> {
  @override
  Widget build(BuildContext context) {
    String name = widget.userEntity!.name ?? '';
    return Scaffold(
      backgroundColor: ColorController.blackColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.05,
            ),
            UserProfileImageWidget(
              // videoEntity: widget.videoEntity,
              // comment: widget.comment,
              user: widget.userEntity!,
            ),
            const SizedBox(height: 10),
            CustomTitle(
              title: name,
              style: TitleStyle.styleBold24,
            ),
            const SizedBox(height: 20),
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
                  title: 'Likes',
                ),
              ],
            ),
            const SizedBox(height: 10),

            // if (widget.videoEntity == null && widget.comment == null ||
            //     widget.videoEntity != null &&
            //         widget.videoEntity!.user.id == widget.userEntity!.id ||
            //     widget.comment != null &&
            //         widget.comment!.user.id == widget.userEntity!.id)
            if (widget.userEntity!.id ==
                UserInfoCubit.get(context).userEntity!.id)
              const ProfileActions(),
            const SizedBox(height: 10),

            const SizedBox(height: 10),
            UserProfileVideosGridView(
              state: this,
            ),
            // Only wrap the UserProfileVideosGridView with the BlocBuilder
            // BlocBuilder<GetUserVideosCubit, UserProfileState>(
            //   builder: (context, state) {
            //     if (state is GetUserVideosLoading) {
            //       return const Center(child: CircularProgressIndicator());
            //     }
            //
            //     if (state is GetUserVideosSuccessState) {
            //       return
            //     } else {
            //       return const SizedBox.shrink();
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
