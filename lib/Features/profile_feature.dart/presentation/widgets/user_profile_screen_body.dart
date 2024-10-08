import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/profile_picture.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/video_contents_screen.dart';
import 'package:shorts/core/widgets/custom_app_bar.dart';

class UserProfileScreenBody extends StatefulWidget {
  const UserProfileScreenBody({
    super.key,
    required this.state,
  });
  final VideoContentsScreenState? state;

  @override
  State<UserProfileScreenBody> createState() => _UserProfileScreenBodyState();
}

class _UserProfileScreenBodyState extends State<UserProfileScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'User Profile'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: BlocConsumer<UserProfileCubit, UserProfileState>(
          listener: (context, state) {
            // You can add any side effects here, like showing a snackbar on error
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserProfilePicture(state: widget.state), // Adjust to get user profile picture if needed
                  const SizedBox(height: 10),
                  Text(state.videos.first.user.name), // Adjust as needed
                  const SizedBox(height: 10),
                  Text(state.videos.first.user.bio), // Adjust as needed
                  const SizedBox(height: 10),
                  const Text('Videos'),
                  const SizedBox(height: 10),
                  // GridView for video thumbnails
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Adjust the number of columns as needed
                        childAspectRatio: 0.75, // Adjust the aspect ratio of each item
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: state.videos.length, // Use the length of the videos list
                      itemBuilder: (context, index) {
                        final video = state.videos[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the video player screen or handle tap
                          },
                          child: Card(
                            elevation: 4.0,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      video.thumbnail, // Assuming video has a thumbnail URL
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    video.description!, // Adjust as needed
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('No videos available.'));
            }
          },
        ),
      ),
    );
  }
}
