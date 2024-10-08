import 'package:flutter/material.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/profile_picture.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/video_contents_screen.dart';
import 'package:shorts/core/widgets/custom_app_bar.dart';

class UserProfileScreenBody extends StatelessWidget {
  const UserProfileScreenBody({
    super.key,
    required this.state,
  });

  final VideoContentsScreenState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'User Profile'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserProfilePicture(state: state),
                const SizedBox(height: 10),
                Text(state.widget.videoEntity.user.name),
                const SizedBox(height: 10),
                Text(state.widget.videoEntity.user.bio),
                const SizedBox(height: 10),
                const Text('Videos'),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
