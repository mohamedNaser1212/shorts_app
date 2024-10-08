import 'package:flutter/material.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_screen_body.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/video_contents_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key, required this.state});
  final VideoContentsScreenState state;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return UserProfileScreenBody(state: widget.state);
  }
}
