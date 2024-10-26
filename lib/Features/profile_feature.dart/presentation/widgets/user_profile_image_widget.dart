import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_contents_screen.dart';

class UserProfileImageWidget extends StatelessWidget {
  const UserProfileImageWidget({
    super.key,
    this.state,
    this.comment,
  });

  final VideoContentsScreenState? state;
  final CommentEntity? comment;

  @override
  Widget build(BuildContext context) {
    const double containerHeight = 150;
    final String profilePicUrl = state?.widget.videoEntity.user.profilePic ??
        comment?.user.profilePic ??
        '';

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: containerHeight,
          color: Colors.grey[200],
        ),
        Positioned(
          bottom: -30,
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 60,
            backgroundImage:
                profilePicUrl.isNotEmpty ? NetworkImage(profilePicUrl) : null,
            child: profilePicUrl.isEmpty
                ? const Icon(Icons.person, size: 40)
                : null,
          ),
        ),
      ],
    );
  }
}
