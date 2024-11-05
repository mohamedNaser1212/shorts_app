import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_contents_screen.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_owner_info_body.dart';

class SharedUserProfileInfoWidget extends StatelessWidget {
  const SharedUserProfileInfoWidget({
    super.key,
    required this.state,
  });

  final VideoContentsScreenState state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.12,
      child: VideoOwnerInfoBody(
        state: state,
        userName: state.widget.favouriteEntity?.user.name ??
            state.widget.videoEntity.sharedBy!.name,
        description: state.widget.favouriteEntity?.user.name ??
            state.widget.videoEntity.sharedUserDescription ??
            '',
      ),
    );
  }
}
