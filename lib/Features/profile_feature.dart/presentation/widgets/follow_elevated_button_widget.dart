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

  @override
  void initState() {
    super.initState();
    _initializeFollowStatus();
  }

  Future<void> _initializeFollowStatus() async {
    await FollowCubit.get(context).isUserFollowed(
      currentUserId: widget.currentUserId,
      targetUserId: widget.targetUserId,
    );
  }

  void toggleFollow() {
    final followCubit = FollowCubit.get(context);

    setState(() {
      isFollowing = !isFollowing;
    });
//followCubit.updateFollowersCount(isFollowing: isFollowing);
    followCubit.followUser(
      currentUserId: widget.currentUserId,
      targetUserId: widget.targetUserId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FollowCubit, FollowState>(
      listener: (context, state) {
        if (state is ToggleFollowErrorState) {
          setState(() {
            isFollowing = !isFollowing;
          });
          ToastHelper.showToast(message: state.message);
        } else if (state is UserActionSuccessState) {
          setState(() {
            isFollowing = state.isFollowing;
          });
        }
      },
      builder: (context, state) {
        if (state is ToggleFollowLoadingState) {
          return const CircularProgressIndicator();
        }

        return ReusableElevatedButton(
          onPressed: toggleFollow,
          backColor: ColorController.purpleColor,
          label: isFollowing ? 'Unfollow' : 'Follow',
        );
      },
    );
  }
}
