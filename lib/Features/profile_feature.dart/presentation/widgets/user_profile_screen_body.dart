import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/profile_picture.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_video_grid_view.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_contents_screen.dart';
import 'package:shorts/core/widgets/custom_app_bar.dart';

class UserProfileScreenBody extends StatefulWidget {
  const UserProfileScreenBody({
    super.key,
    required this.state,
  });
  final VideoContentsScreenState? state;

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
        child: BlocConsumer<UserProfileCubit, UserProfileState>(
          listener: (context, state) {
            if (state is GetUserVideosError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is GetUserVideosLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetUserVideosSuccessState) {
              if (state.videos != []) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    UserProfilePicture(state: widget.state),
                    const SizedBox(height: 10),
                    Text(state.videos.first.user.name),
                    const SizedBox(height: 10),
                    Text(state.videos.first.user.bio),
                    const SizedBox(height: 10),

                    const Text('Videos'),
                    const SizedBox(height: 10),
                    // GridView for video thumbnails
                    UserProfileVideosGridView(
                      state: state,
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('No videos available.'));
              }
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
