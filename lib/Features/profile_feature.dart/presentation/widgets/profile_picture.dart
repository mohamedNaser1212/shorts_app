import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/video_contents_screen.dart';

class UserProfilePicture extends StatelessWidget {
  const UserProfilePicture({
    super.key,
    this.state,
    this.comment,
  });

  final VideoContentsScreenState? state;

  final CommentEntity? comment;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey,
      radius: 20,
      child: Image.network(state?.widget.videoEntity.user.profilePic??comment?.user.profilePic??''),
    );
  }
}
