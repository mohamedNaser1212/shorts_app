import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/follow_cubit/follow_cubit.dart';

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

  @override
  void initState() {
    super.initState();
    _checkFollowStatus();
    FollowCubit.of(context).getFollowersCount(userId: widget.targetUserId);
  }

  void _checkFollowStatus() async {
    await context.read<FollowCubit>().isUserFollowed(
          currentUserId: widget.currentUserId,
          targetUserId: widget.targetUserId,
        );
    setState(() {
      isLoading = false; // Set loading to false once status is determined
    });
  }

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });

    // Update followers count based on the follow/unfollow action
    context
        .read<FollowCubit>()
        .followUser(
          currentUserId: widget.currentUserId,
          targetUserId: widget.targetUserId,
        )
        .then((_) {
      context.read<FollowCubit>().updateFollowersCount(
            userId: widget.targetUserId,
            isFollowing: isFollowing,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowCubit, FollowState>(
      builder: (context, state) {
        if (state is UserActionSuccessState) {
          isFollowing = state.isFollowing;
        }

        return isLoading
            ? const SizedBox.shrink()
            : ReusableElevatedButton(
                onPressed: toggleFollow,
                backColor: ColorController.purpleColor,
                label: isFollowing ? 'Unfollow' : 'Follow',
              );
      },
    );
  }
}
