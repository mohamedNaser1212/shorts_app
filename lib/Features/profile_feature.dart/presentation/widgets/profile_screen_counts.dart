import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../cubit/follow_cubit/follow_cubit.dart';
import 'custom_user_profile_information_widget.dart';
import 'followers_count_widget.dart';
import 'followings_count_widget.dart';

class UserProfileCountWidgets extends StatefulWidget {
  const UserProfileCountWidgets({
    super.key,
    required this.userEntity,
  });

  final UserEntity userEntity;

  @override
  State<UserProfileCountWidgets> createState() =>
      _UserProfileCountWidgetsState();
}

class _UserProfileCountWidgetsState extends State<UserProfileCountWidgets> {
  @override
  void initState() {
    super.initState();
    final followCubit = BlocProvider.of<FollowCubit>(context);
    followCubit.getFollowersCount(userId: widget.userEntity.id!);
    followCubit.getFollowingsCount(userId: widget.userEntity.id!);
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
          FollowingsCountWidget(userEntity: widget.userEntity),
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
