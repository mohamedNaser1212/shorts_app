import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/domain/use_case/user_profile_videos_use_case.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_screen_body.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_contents_screen.dart';
import 'package:shorts/core/service_locator/service_locator.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key, required this.state});
  final VideoContentsScreenState state;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileCubit(
   getUserInfoUseCase: getIt.get<UserProfileVideosUseCase>(),
      )..getUserVideos(userId: widget.state.widget.videoEntity.user.id!),
      child: UserProfileScreenBody(state: widget.state),
    );
  }
}
