import 'package:flutter/material.dart';

import '../../../../core/user_info/domain/user_entity/user_entity.dart';

class UserProfileImageWidget extends StatelessWidget {
  const UserProfileImageWidget({
    super.key,
    // this.videoEntity,
    // this.comment,
    this.user,
  });
  // String? userId;
  // final VideoEntity? videoEntity;
  // final CommentEntity? comment;
  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    // const double containerHeight = 150;
    final String profilePicUrl = user?.profilePic ?? '';

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
