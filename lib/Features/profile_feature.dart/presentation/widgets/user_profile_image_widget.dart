import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

class UserProfileImageWidget extends StatelessWidget {
  const UserProfileImageWidget(
      {super.key, this.videoEntity, this.comment, this.user});

  final VideoEntity? videoEntity;
  final CommentEntity? comment;
  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    // const double containerHeight = 150;
    final String profilePicUrl = videoEntity?.user.profilePic ??
        comment?.user.profilePic ??
        user?.profilePic ??
        '';

    return CircleAvatar(
      backgroundColor: Colors.grey,
      radius: 80,
      backgroundImage:
          profilePicUrl.isNotEmpty ? NetworkImage(profilePicUrl) : null,
      child: profilePicUrl.isEmpty ? const Icon(Icons.person, size: 40) : null,
    );

    //   Stack(
    //   clipBehavior: Clip.none,
    //   alignment: Alignment.bottomCenter,
    //   children: [
    //     Container(
    //       width: MediaQuery.of(context).size.width,
    //       height: containerHeight,
    //       color: Colors.grey[200],
    //     ),
    //     Positioned(
    //       bottom: -30,
    //       child: CircleAvatar(
    //         backgroundColor: Colors.grey,
    //         radius: 60,
    //         backgroundImage:
    //             profilePicUrl.isNotEmpty ? NetworkImage(profilePicUrl) : null,
    //         child: profilePicUrl.isEmpty
    //             ? const Icon(Icons.person, size: 40)
    //             : null,
    //       ),
    //     ),
    //   ],
    // );
  }
}
