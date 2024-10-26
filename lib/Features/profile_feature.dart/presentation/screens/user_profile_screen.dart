import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/domain/use_case/user_profile_videos_use_case.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_screen_body.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_contents_screen.dart';
import 'package:shorts/core/service_locator/service_locator.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen(
      {super.key, required this.state, required this.isShared});
  final VideoContentsScreenState state;
  final bool isShared;

  @override
  State<UserProfileScreen> createState() => UserProfileScreenState();
}

class UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetUserVideosCubit(
        getUserInfoUseCase: getIt.get<UserProfileVideosUseCase>(),
      )..getUserVideos(
          userId: widget.isShared == false
              ? widget.state.widget.videoEntity.user.id!
              : widget.state.widget.videoEntity.sharedBy!.id!),
      child: UserProfileScreenBody(state: widget.state, userProfileState: this),
    );
  }
}
