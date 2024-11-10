import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/follow_cubit/follow_cubit.dart';

import '../../../../core/managers/styles_manager/color_manager.dart';
import '../../../../core/widgets/reusable_elevated_botton.dart';

class FollowElevatedButtonWidget extends StatefulWidget {
  final String currentUserId;
  final String targetUserId;

  const FollowElevatedButtonWidget({
    super.key,
    required this.currentUserId,
    required this.targetUserId,
  });

  @override
  _FollowElevatedButtonWidgetState createState() =>
      _FollowElevatedButtonWidgetState();
}

class _FollowElevatedButtonWidgetState
    extends State<FollowElevatedButtonWidget> {
  bool isFollowing = false;
  int followingCount = 0;

  // Track previous state for revert in case of error
  bool previousIsFollowing = false;
  int previousFollowingCount = 0;

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
    // setState(() {
    //   isFollowing = result;
    //   print('isFollowing: $isFollowing');
    // });
  }

  // Fetch followers and following counts

  // Toggle follow action: Follow/Unfollow
  void toggleFollow() {
    // Save the previous state for potential revert
    previousIsFollowing = isFollowing;
    previousFollowingCount = followingCount;

    // if (isFollowing) {
    //   setState(() {
    //     followingCount--; // Decrease the following count when unfollowed
    //   });
    // } else {
    //   setState(() {
    //     followingCount++; // Increase the following count when followed
    //   });
    // }

    context.read<FollowCubit>().followUser(
          currentUserId: widget.currentUserId,
          targetUserId: widget.targetUserId,
          targetUserName: 'TargetUserName', // Provide the target user name
        );
  }

  @override
  Widget build(BuildContext context) {
    int followersCount = FollowCubit.of(context).followerCounts;

    return BlocConsumer<FollowCubit, FollowState>(
      listener: (context, state) {
        // if (state is ToggleFollowSuccessState) {
        //   // setState(() {
        //   //   isFollowing = true;
        //   // });
        // } else if (state is UserUnfollowedSuccessState) {
        //   setState(() {
        //     isFollowing = false;
        //   });
        // } else if (state is UserActionErrorState) {
        //   setState(() {
        //     isFollowing = previousIsFollowing;
        //     followingCount = previousFollowingCount;
        //   });
        //   // Show error toast
        //   Fluttertoast.showToast(
        //     msg: "An error occurred, please try again.",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 16.0,
        //   );
        // }
      },
      builder: (context, state) {
        return Column(
          children: [
            // Text('Followers: $followersCount',
            //     style: TextStyle(
            //         fontSize: 16, color: ColorController.purpleColor)),

            ReusableElevatedButton(
              onPressed: toggleFollow,
              backColor: ColorController.purpleColor,
              label: isFollowing ? 'Unfollow' : 'Follow',
            ),
          ],
        );
      },
    );
  }
}
