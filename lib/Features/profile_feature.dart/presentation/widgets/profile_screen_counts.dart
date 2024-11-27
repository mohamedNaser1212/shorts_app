import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';

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
  @override
  void initState() {
    super.initState();
    final followCubit = BlocProvider.of<FollowCubit>(context);
    followCubit.getFollowersCount(userId: widget.userEntity.id!);
    // followCubit.getFollowingsCount(userId: widget.userEntity.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FollowersCount(userEntity: widget.userEntity),
          const SizedBox(width: 50),
          if (widget.userEntity.id !=
              UserInfoCubit.get(context).userEntity!.id!)
            BlocBuilder<FollowCubit, FollowState>(builder: (context, state) {
              if (state is FollowingCountLoadingState) {
                return const CustomUserProfileInformations(
                  number: 0,
                  title: 'Followings',
                );
              } else if (state is FollowingCountErrorState) {
                return const CustomUserProfileInformations(
                  number: 0,
                  title: 'Followings',
                );
              } else if (state is FollowingCountSuccessState) {
                return CustomUserProfileInformations(
                  number: FollowCubit.get(context)
                          .followingsCounts[widget.userEntity.id] ??
                      0,
                  title: 'Followings',
                );
              }
              return const CustomUserProfileInformations(
                number: 0,
                title: 'Followings',
              );
            })
          else
            CustomUserProfileInformations(
              number: widget.userEntity.followingCount,
              title: 'Followings',
            ),
          const SizedBox(width: 50),
          CustomUserProfileInformations(
            number: widget.userEntity.likesCount,
            title: 'Likes',
          ),
        ],
      ),
    );
  }
}

class FollowersCount extends StatelessWidget {
  const FollowersCount({super.key, required this.userEntity});
  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowCubit, FollowState>(
      builder: (context, state) {
        // Get the follower count from the map cache or use the default
        final cachedFollowersCount =
            FollowCubit.get(context).followersCounts[userEntity.id];

        return CustomUserProfileInformations(
          number: cachedFollowersCount ?? userEntity.followersCount,
          title: 'Followers',
        );
      },
    );
  }
}
