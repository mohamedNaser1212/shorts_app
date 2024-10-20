import 'package:flutter/material.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_video_grid_view_body.dart';

class UserProfileVideosGridView extends StatelessWidget {
  const UserProfileVideosGridView({
    super.key,
    required this.state,
  });
  final GetUserVideosSuccessState state;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: _gridDelegate(),
        itemCount: state.videos.length,
        itemBuilder: _builder,
      ),
    );
  }

  Widget? _builder(context, index) {
    final video = state.videos[index];

    return UserProfileVideosGridViewBody(
      video: video,
      videos: [...state.videos],  
      index:  index,
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount _gridDelegate() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.75,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
    );
  }
}
