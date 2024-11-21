import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/follow_cubit/follow_cubit.dart';
import 'package:shorts/core/service_locator/service_locator.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/widgets/custom_progress_indicator.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../domain/use_case/check_user_follow.dart';
import '../../domain/use_case/follow_use_case.dart';
import '../../domain/use_case/get_followers_count_use_case.dart';
import '../../domain/use_case/get_followings_count_use_case.dart';
import '../widgets/user_profile_screen_body.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({
    super.key,
    this.user,
  });

  final UserEntity? user;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FollowCubit(
            followUserUseCase: getIt.get<ToggleFollowUserUseCase>(),
            getFollowersCountUseCase: getIt.get<GetFollowersCountUseCase>(),
            getFollowingCountUseCase: getIt.get<GetFollowingCountUseCase>(),
            isUserFollowedUseCase: getIt.get<IsUserFollowedUseCase>(),
          ),
        ),
      ],
      child: BlocBuilder<UserInfoCubit, UserInfoState>(
        builder: _builder,
      ),
    );
  }

  Widget _builder(BuildContext context, UserInfoState state) {
    final userEntity = UserInfoCubit.get(context).userEntity;

    // if (state is GetUserInfoSuccessState) {
    return BlockInternactionLoadingWidget(
      isLoading: state is SignOutLoadingState,
      child: UserProfileScreenBody(
        userEntity: user ?? userEntity,
      ),
    );
  }
}
