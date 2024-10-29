import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/get_user_videos_state.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/screens/user_profile_screen.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_image_widget.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_video_grid_view.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/widgets/custom_app_bar.dart';
import 'package:shorts/core/widgets/custom_title.dart';

class UserProfileScreenBody extends StatefulWidget {
  const UserProfileScreenBody({
    super.key,
    this.videoEntity,
    required this.userProfileState,
    this.comment,
  });
  final VideoEntity? videoEntity;
  final UserProfileScreenState userProfileState;
  final CommentEntity? comment;

  @override
  State<UserProfileScreenBody> createState() => UserProfileScreenBodyState();
}

class UserProfileScreenBodyState extends State<UserProfileScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'User Profile'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: BlocBuilder<GetUserVideosCubit, UserProfileState>(
          builder: (context, state) {
            if (state is GetUserVideosLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final user = widget.userProfileState.widget.isShared == true
                ? widget.videoEntity?.sharedBy!
                : widget.videoEntity?.user ?? widget.comment?.user;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserProfileImageWidget(
                  videoEntity: widget.videoEntity,
                  comment: widget.comment,
                ),
                const SizedBox(height: 40),
                CustomTitle(
                  title: widget.comment?.user.name ?? user!.name,
                  style: TitleStyle.style16,
                ),
                const SizedBox(height: 10),
                CustomTitle(
                  title: widget.comment?.user.bio ?? user!.bio,
                  style: TitleStyle.style16,
                ),
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
