import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/confirm_recording_widget.dart';
import 'package:shorts/core/video_controller/video_controller.dart';

import '../../../../../core/widgets/custom_icon_widget.dart';
import '../../video_cubit/upload_videos_cubit/upload_videos_cubit.dart';

class GallaryIconWidget extends StatelessWidget {
  const GallaryIconWidget({super.key, required this.notifier});
  final VideoController notifier;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16.0,
      right: 16.0,
      child: notifier.isRecording ||
              notifier.videoFile != null ||
              !notifier.isPermissionGranted
          ? ConfirmRecordingWidget(
              videoFile: notifier.videoFile,
              videoController: notifier,
            )
          : IconButton(
              icon: const CustomIconWidget(
                icon: Icons.image,
                color: Colors.white,
              ),
              onPressed: () {
                UploadVideosCubit.get(context).pickVideo();
              },
            ),
    );
  }
}
//import 'package:flutter/material.dart';
// import 'package:shorts/core/video_controller/video_controller.dart';
//
// import '../../../../../core/widgets/custom_icon_widget.dart';
// import '../../video_cubit/upload_videos_cubit/upload_videos_cubit.dart';
//
// class GallaryIconWidget extends StatefulWidget {
//   const GallaryIconWidget({super.key, required this.notifier});
//   final VideoController notifier;
//
//   @override
//   State<GallaryIconWidget> createState() => _GallaryIconWidgetState();
// }
//
// class _GallaryIconWidgetState extends State<GallaryIconWidget> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     print(widget.notifier.isRecording);
//     print(widget.notifier.isPermissionGranted);
//     print(widget.notifier.videoFile);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 16.0,
//       right: 16.0,
//       child: widget.notifier.isRecording || !widget.notifier.isPermissionGranted
//           ? const SizedBox()
//           : widget.notifier.videoFile != null
//               ? IconButton(
//                   icon: const CustomIconWidget(
//                     icon: Icons.save,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     print("Save video: ${widget.notifier.videoFile!.path}");
//                   },
//                 )
//               : IconButton(
//                   icon: const CustomIconWidget(
//                     icon: Icons.image,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     UploadVideosCubit.get(context).pickVideo();
//                   },
//                 ),
//     );
//   }
// }
