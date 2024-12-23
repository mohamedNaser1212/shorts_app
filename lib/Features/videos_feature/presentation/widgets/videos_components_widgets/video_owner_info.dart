import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_contents_screen.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_owner_profile_info_widget.dart';

class VideoOwnerInfo extends StatelessWidget {
  const VideoOwnerInfo({
    super.key,
    required this.state,
  });

  final VideoContentsScreenState state;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 60,
      right: MediaQuery.of(context).size.width * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            children: [
              VideoOwnerProfileInfoWidget(state: state),
            ],
          ),
        ],
      ),
    );
  }
}
