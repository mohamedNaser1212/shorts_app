// import 'package:flutter/material.dart';
// import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_contents_screen.dart';
// import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_owner_info_body.dart';
//
// class SharedUserProfileInfoWidget extends StatelessWidget {
//   const SharedUserProfileInfoWidget({
//     super.key,
//     required this.state,
//   });
//
//   final VideoContentsScreenState state;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width * 0.8,
//       child: VideoOwnerInfoBody(
//         state: state,
//         userName: state.widget.videoEntity.sharedBy!.name,
//         description: state.widget.videoEntity.sharedUserDescription ?? '',
//       ),
//     );
//   }
// }
