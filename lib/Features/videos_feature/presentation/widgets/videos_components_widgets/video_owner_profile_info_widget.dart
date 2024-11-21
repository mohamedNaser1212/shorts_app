import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_components_widget.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_contents_screen.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_owner_info_body.dart';

class VideoOwnerProfileInfoWidget extends StatelessWidget {
  const VideoOwnerProfileInfoWidget(
      {super.key, required this.state, this.videoComponentsWidgetState});

  final VideoContentsScreenState state;
  final VideoComponentsWidgetState? videoComponentsWidgetState;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: VideoOwnerInfoBody(
        state: state,
        userName: state.widget.videoEntity.user.name,
        description: state.widget.videoEntity.description,
      ),

      //  CustomListTile(
      //   leading: UserProfilePicture(state: state),
      //   title: state.widget.videoEntity.user.name,
      // //   subtitle: state.widget.videoEntity.description,
      // //   color: ColorController.whiteColor,
      // // ),
    );
  }
}
