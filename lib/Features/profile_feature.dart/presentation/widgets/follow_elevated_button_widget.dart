import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/follow_cubit/follow_cubit.dart';
import 'package:shorts/core/functions/toast_function.dart';

import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/widgets/reusable_elevated_botton.dart';
import '../../../videos_feature/presentation/widgets/videos_components_widgets/video_contents_screen.dart';

class FollowElevatedButtonWidget extends StatefulWidget {
  final String currentUserId;
  final String targetUserId;
  final VideoContentsScreenState? state;

  const FollowElevatedButtonWidget({
    super.key,
    required this.currentUserId,
    required this.targetUserId,
    this.state,
  });

  @override
  _FollowElevatedButtonWidgetState createState() =>
      _FollowElevatedButtonWidgetState();
}

class _FollowElevatedButtonWidgetState
    extends State<FollowElevatedButtonWidget> {
  bool isFollowing = false;
  bool isLoading = true;
  int previousFollowersCount = 0;

  @override
  void initState() {
    super.initState();
    _checkFollowStatus();
    FollowCubit.get(context).getFollowersCount(userId: widget.targetUserId);
  }

  void _checkFollowStatus() async {
    await context.read<FollowCubit>().isUserFollowed(
          currentUserId: widget.currentUserId,
          targetUserId: widget.targetUserId,
        );
    setState(() {
      isLoading = false;
    });
  }

  void toggleFollow() {
    previousFollowersCount = FollowCubit.get(context).followerCounts;

    setState(() {
      isFollowing = !isFollowing;
    });

    FollowCubit.get(context).updateFollowersCount(isFollowing: isFollowing);

    FollowCubit.get(context).followUser(
      currentUserId: widget.currentUserId,
      targetUserId: widget.targetUserId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowCubit, FollowState>(builder: (context, state) {
      if (state is UserActionSuccessState) {
        isFollowing = state.isFollowing;
      } else if (state is ToggleFollowErrorState) {
        FollowCubit.get(context)
            .updateFollowersCount(isFollowing: !isFollowing);
        isFollowing = !isFollowing;
        ToastHelper.showToast(message: state.message);
      }

      return ReusableElevatedButton(
        onPressed: toggleFollow,
        backColor: ColorController.purpleColor,
        label: isFollowing ? 'Unfollow' : 'Follow',
      );
    });
  }
}
