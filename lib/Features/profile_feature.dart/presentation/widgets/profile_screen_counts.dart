import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/core/service_locator/service_locator.dart';
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
    if (widget.userEntity.id != UserInfoCubit.get(context).userEntity!.id!) {
      final followCubit = BlocProvider.of<FollowCubit>(context);
      followCubit.getFollowersCount(userId: widget.userEntity.id!);
      followCubit.getFollowingsCount(userId: widget.userEntity.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<FollowCubit>()
        ..getFollowingsCount(userId: widget.userEntity.id!)
        ..getFollowersCount(userId: widget.userEntity.id!),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (widget.userEntity.id !=
                UserInfoCubit.get(context).userEntity!.id!)
              BlocBuilder<FollowCubit, FollowState>(
                builder: (context, state) {
                  final followCubit = BlocProvider.of<FollowCubit>(context);
                  final followersCount = followCubit
                      .getFollowerCountForUser(widget.userEntity.id!);

                  return CustomUserProfileInformations(
                    number: followersCount,
                    title: 'Followers',
                  );
                },
              )
            else
              CustomUserProfileInformations(
                number: widget.userEntity.followersCount,
                title: 'Followers',
              ),
            const SizedBox(width: 50),
            if (widget.userEntity.id !=
                UserInfoCubit.get(context).userEntity!.id!)
              BlocBuilder<FollowCubit, FollowState>(
                builder: (context, state) {
                  final followCubit = BlocProvider.of<FollowCubit>(context);
                  final followingsCount = followCubit
                      .getFollowingCountForUser(widget.userEntity.id!);

                  return CustomUserProfileInformations(
                    number: followingsCount,
                    title: 'Followings',
                  );
                },
              )
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
      ),
    );
  }
}
