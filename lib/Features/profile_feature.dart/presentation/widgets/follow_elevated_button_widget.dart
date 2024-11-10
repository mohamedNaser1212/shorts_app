import 'package:flutter/material.dart';

import '../../../../core/widgets/reusable_elevated_botton.dart';

class FollowElevatedButtonWidget extends StatefulWidget {
  const FollowElevatedButtonWidget({super.key});

  @override
  _FollowElevatedButtonWidgetState createState() =>
      _FollowElevatedButtonWidgetState();
}

class _FollowElevatedButtonWidgetState
    extends State<FollowElevatedButtonWidget> {
  bool isFollowing = false;

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReusableElevatedButton(
      onPressed: toggleFollow,
      label: isFollowing ? 'Unfollow' : 'Follow',
    );
  }
}
