import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../cubit/follow_cubit/follow_cubit.dart';
import 'custom_user_profile_information_widget.dart';

class FollowersCount extends StatelessWidget {
  const FollowersCount({super.key, required this.userEntity});
  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowCubit, FollowState>(builder: (context, state) {
      final cachedFollowersCount =
          FollowCubit.get(context).followersCounts[userEntity.id];

      return CustomUserProfileInformations(
        number: cachedFollowersCount ?? userEntity.followersCount,
        title: 'Followers',
      );
    });
  }
}
