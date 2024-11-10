import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/user_info/cubit/user_info_cubit.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../cubit/follow_cubit/follow_cubit.dart';
import 'custom_user_profile_information_widget.dart';

class FollowingFollowersCountWidget extends StatefulWidget {
  const FollowingFollowersCountWidget({
    super.key,
    required this.userEntity,
  });

  final UserEntity userEntity;

  @override
  State<FollowingFollowersCountWidget> createState() =>
      _FollowingFollowersCountWidgetState();
}

class _FollowingFollowersCountWidgetState
    extends State<FollowingFollowersCountWidget> {
  int followersCount = 0;
  int followingCount = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   FollowCubit.of(context).getFollowersCount(userId: widget.userEntity.id!);
  //   FollowCubit.of(context).getFollowingsCount(userId: widget.userEntity.id!);
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowCubit, FollowState>(builder: (context, state) {
      if (state is FollowersCountSuccessState) {
        followersCount = state.count;
      }

      if (state is FollowingCountSuccessState) {
        followingCount = state.count;
      }

      return BlocBuilder<UserInfoCubit, UserInfoState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (state is GetUserInfoSuccessState &&
                  state.userEntity!.id == widget.userEntity.id)
                CustomUserProfileInformations(
                  number: state.userEntity?.followersCount ?? followersCount,
                  title: 'Followers',
                )
              else
                CustomUserProfileInformations(
                  number: followersCount,
                  title: 'Followers',
                ),
              const SizedBox(width: 50),
              if (state is GetUserInfoSuccessState &&
                  state.userEntity!.id == widget.userEntity.id)
                CustomUserProfileInformations(
                  number: state.userEntity?.followingCount ?? followingCount,
                  title: 'Following',
                )
              else
                CustomUserProfileInformations(
                  number: followingCount,
                  title: 'Following',
                ),
              const SizedBox(width: 50),
              const CustomUserProfileInformations(number: 0, title: 'Likes'),
            ],
          );
        },
      );
    });
  }
}
