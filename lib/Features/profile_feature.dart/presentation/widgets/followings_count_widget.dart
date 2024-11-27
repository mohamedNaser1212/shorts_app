import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

import '../cubit/follow_cubit/follow_cubit.dart';
import 'custom_user_profile_information_widget.dart';

class FollowingsCountWidget extends StatelessWidget {
  const FollowingsCountWidget({super.key, required this.userEntity});
  final UserEntity userEntity;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowCubit, FollowState>(builder: (context, state) {
      return CustomUserProfileInformations(
        number: userEntity.followingCount,
        title: 'Followings',
      );
    });
  }
}
