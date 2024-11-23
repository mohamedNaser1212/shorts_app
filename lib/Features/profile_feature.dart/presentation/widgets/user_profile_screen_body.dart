import 'package:flutter/material.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/profile_actions.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/profile_screen_counts.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_image_widget.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_video_grid_view.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/widgets/custom_app_bar.dart';
import 'package:shorts/core/widgets/custom_title.dart';

import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import 'follow_elevated_button_widget.dart';

class UserProfileScreenBody extends StatefulWidget {
  const UserProfileScreenBody({
    super.key,
    this.userEntity,
    required this.showLeadingIcon,
  });

  final UserEntity? userEntity;
  final bool showLeadingIcon;

  @override
  State<UserProfileScreenBody> createState() => UserProfileScreenBodyState();
}

class UserProfileScreenBodyState extends State<UserProfileScreenBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cubit = GetUserVideosCubit.get(context);

    if (cubit.currentUserId != widget.userEntity!.id) {
      cubit.reset();
      cubit.getUserVideos(
        userId: widget.userEntity!.id!,
      );
    }

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final cubit = GetUserVideosCubit.get(context);
    final scrollPosition = _scrollController.position;
    // Check if we're within 40% of the total scrollable height
    if (!cubit.isLoadingMore &&
        cubit.hasMoreVideos &&
        scrollPosition.pixels >= scrollPosition.maxScrollExtent * 0.4) {
      cubit.loadMoreVideos(userId: widget.userEntity!.id!);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.userEntity!.name;
    return Scaffold(
      appBar: widget.showLeadingIcon == true
          ? const CustomAppBar(
              title: '',
              backColor: ColorController.transparentColor,
              showLeadingIcon: true,
            )
          : null,
      backgroundColor: ColorController.blackColor,
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
          Column(
            children: [
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
              const SizedBox(height: 20),
              UserProfileVideosGridView(state: this),
            ],
          ),
        ],
      ),
    );
  }
}
