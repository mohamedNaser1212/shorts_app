import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/Features/profile_feature.dart/domain/use_case/user_profile_videos_use_case.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:shorts/Features/profile_feature.dart/presentation/widgets/user_profile_screen_body.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/service_locator/service_locator.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({
    super.key,
    required this.isShared,
    this.videoEntity,
    this.user,
    this.comment,
  });
  final VideoEntity? videoEntity;
  final UserEntity? user;

  final bool isShared;
  final CommentEntity? comment;

  @override
  State<UserProfileScreen> createState() => UserProfileScreenState();
}

class UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print('user${widget.user!.name}');
  }

  @override
  Widget build(BuildContext context) {
    final check = widget.comment?.user.id ??
        widget.videoEntity?.user.id ??
        widget.user?.id;
    return BlocProvider(
      create: (context) => GetUserVideosCubit(
        getUserInfoUseCase: getIt.get<UserProfileVideosUseCase>(),
      )..getUserVideos(
          userId: check!,
        ),
      child: UserProfileScreenBody(
        videoEntity: widget.videoEntity,
        comment: widget.comment,
        userProfileState: this,
      ),
    );
  }
}
