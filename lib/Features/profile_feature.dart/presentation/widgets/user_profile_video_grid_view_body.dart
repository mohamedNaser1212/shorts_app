import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/core/functions/navigations_functions.dart';

import '../../../videos_feature/presentation/widgets/videos_components_widgets/videos_list.dart';

class UserProfileVideosGridViewBody extends StatefulWidget {
  const UserProfileVideosGridViewBody({
    super.key,
    required this.video,
    required this.videos,
    required this.index,
  });

  final VideoEntity video;
  final List<VideoEntity> videos;
  final int index;

  @override
  State<UserProfileVideosGridViewBody> createState() =>
      UserProfileVideosGridViewBodyState();
}

class UserProfileVideosGridViewBodyState
    extends State<UserProfileVideosGridViewBody> {
  final bool fromProfile = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(
        context,
      ),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.2,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: CachedNetworkImage(
          imageUrl: widget.video.thumbnail,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }

  void _onTap(
    BuildContext context,
  ) {
    NavigationManager.navigateTo(
      context: context,
      screen: VideoListItem(
        videoEntity: widget.video,
        fromProfile: true,
      ),
    );
  }
}
