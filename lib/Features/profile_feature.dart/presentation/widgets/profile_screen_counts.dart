import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    followCubit.getFollowingsCount(userId: widget.userEntity.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BlocBuilder<FollowCubit, FollowState>(
          builder: (context, state) {
            return CustomUserProfileInformations(
              number: FollowCubit.get(context).followerCounts,
              title: 'Followers',
            );
          },
        ),
        const SizedBox(width: 50),
        CustomUserProfileInformations(
          number: widget.userEntity.followingCount,
          title: 'Following',
        ),
        const SizedBox(width: 50),
        CustomUserProfileInformations(
          number: widget.userEntity.likesCount,
          title: 'Likes',
        ),
      ],
    );
  }
}
