import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/service_locator/service_locator.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/user_info/domain/use_cases/get_user_info_use_case.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

import '../../../authentication_feature/domain/authentication_use_case/sign_out_use_case.dart';
import '../../domain/use_case/user_profile_videos_use_case.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../widgets/user_profile_screen_body.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({
    super.key,
    required this.isShared,
    this.videoEntity,
    this.user,
    this.comment,
  });

  final VideoEntity? videoEntity;
  final UserEntity? user;
  final bool isShared;
  final CommentEntity? comment;

  @override
  State<UserProfileScreen> createState() => UserProfileScreenState();
}

class UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = UserInfoCubit.get(context).userEntity;
    final check = widget.comment?.user.id ??
        widget.videoEntity?.user.id ??
        widget.user?.id ??
        user?.id;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserInfoCubit(
            getUserUseCase: getIt.get<GetUserInfoUseCase>(),
            signOutUseCase: getIt.get<SignOutUseCase>(),
          )..getUserData(),
        ),
        BlocProvider(
          create: (context) => GetUserVideosCubit(
            getUserInfoUseCase: getIt.get<UserProfileVideosUseCase>(),
          )..getUserVideos(userId: check!),
        ),
      ],
      child: BlocConsumer<UserInfoCubit, UserInfoState>(
        listener: _listener,
        builder: _builder,
      ),
    );
  }

  Widget _builder(BuildContext context, UserInfoState state) {
    if (state is GetUserInfoSuccessState) {
      return UserProfileScreenBody(
        videoEntity: widget.videoEntity,
        comment: widget.comment,
        userProfileState: this,
        userEntity: state.userEntity,
      );
    }

    return Scaffold(
      body: Center(
        child: state is GetUserInfoLoadingState
            ? const CircularProgressIndicator()
            : const Text('Error loading user data'),
      ),
    );
  }

  void _listener(BuildContext context, UserInfoState state) {
    if (state is GetUserInfoErrorState) {
      // Handle error state, e.g., show a toast or dialog
      print("Error loading user info: ${state.message}");
    }
  }
}
