import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_contents_screen.dart';

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
      radius: 25,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: state?.widget.videoEntity.user.profilePic ??
              comment?.user.profilePic ??
              '',
          fit: BoxFit.cover,
          width: 64,
          height: 64,
        ),
      ),
    );
  }
}
