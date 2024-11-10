import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/follow_cubit/follow_cubit.dart';
import 'package:shorts/core/service_locator/service_locator.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../domain/use_case/check_user_follow.dart';
import '../../domain/use_case/follow_use_case.dart';
import '../../domain/use_case/get_followers_count_use_case.dart';
import '../../domain/use_case/get_followings_count_use_case.dart';
import '../../domain/use_case/user_profile_videos_use_case.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../widgets/user_profile_screen_body.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({
    super.key,
    this.user,
    // this.videoEntity,
    // this.user,
    // this.comment,
  });
//  final String? userId;
  // final VideoEntity? videoEntity;
  final UserEntity? user;
  // final bool isShared;
  // final CommentEntity? comment;

  @override
  State<UserProfileScreen> createState() => UserProfileScreenState();
}

class UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<UserInfoCubit>(context).getUserById(uId: widget.userId!);
  }

  @override
  Widget build(BuildContext context) {
    final user = UserInfoCubit.get(context).userEntity;
    final check = widget.user?.id ?? user!.id!;
    // widget.comment?.user.id ??
    // widget.videoEntity?.user.id ??
    // widget.user?.id ??
    // user?.id;

    return MultiBlocProvider(
      providers: [
        // // Bloc for fetching user data
        // BlocProvider(
        //   create: (context) => UserInfoCubit(
        //     getUserUseCase: getIt.get<GetUserInfoUseCase>(),
        //     signOutUseCase: getIt.get<SignOutUseCase>(),
        //   )..getUserData(),
        // ),
        BlocProvider(
          create: (context) => GetUserVideosCubit(
            getUserInfoUseCase: getIt.get<UserProfileVideosUseCase>(),
          )..getUserVideos(userId: check),
        ),
        BlocProvider(
          create: (context) => FollowCubit(
            followUserUseCase: getIt.get<ToggleFollowUserUseCase>(),
            //   unfollowUserUseCase: getIt.get<UnfollowUserUseCase>(),
            getFollowersCountUseCase: getIt.get<GetFollowersCountUseCase>(),
            getFollowingCountUseCase: getIt.get<GetFollowingCountUseCase>(),
            isUserFollowedUseCase: getIt.get<IsUserFollowedUseCase>(),
          ),
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
        // videoEntity: widget.videoEntity,
        // comment: widget.comment,.
        userEntity: widget.user ?? state.userEntity,

        // userEntity: state.userEntity,
      );
    }

    return const SizedBox.shrink();
  }

  void _listener(BuildContext context, UserInfoState state) {
    if (state is GetUserInfoErrorState) {
      // Handle error state, e.g., show a toast or dialog
      print("Error loading user info: ${state.message}");
    }
  }
}
