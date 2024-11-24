import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/authentication_feature/domain/authentication_use_case/sign_out_use_case.dart';
import 'package:shorts/Features/authentication_feature/presentation/cubit/sign_out_cubit/sign_out_cubit.dart';
import 'package:shorts/core/service_locator/service_locator.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../widgets/user_profile_screen_body.dart';

// ignore: must_be_immutable
class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({
    super.key,
    this.user,
    this.showLeadingIcon = true,
  });
  bool? showLeadingIcon;

  final UserEntity? user;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SignOutCubit(signOutUseCase: getIt.get<SignOutUseCase>()),
        ),
      ],
      child: BlocBuilder<UserInfoCubit, UserInfoState>(
        builder: _builder,
      ),
    );
  }

  Widget _builder(BuildContext context, UserInfoState state) {
    final userEntity = UserInfoCubit.get(context).userEntity;

    return BlocBuilder<SignOutCubit, SignOutState>(
      builder: (context, state) {
        return UserProfileScreenBody(
          userEntity: user ?? userEntity,
          showLeadingIcon: showLeadingIcon!,
        );
      },
    );
  }
}
