// import 'package:flutter/material.dart';
// import 'package:shorts/Features/layout/presentation/screens/choose_video_page.dart';
// import 'package:shorts/Features/layout/presentation/widgets/upload_botton_widget.dart';
// import 'package:shorts/Features/layout/presentation/widgets/video_description_form_field.dart';
// import 'package:shorts/Features/videos_feature/presentation/widgets/select_video_botton.dart';
// import 'package:shorts/core/widgets/custom_app_bar.dart';
// import 'package:shorts/core/widgets/thumbnail_widget.dart';

// class ChooseVideoPageBody extends StatelessWidget {
//   final ChooseVideoPageState state;
//   final String? selectedVideoPath;

//   const ChooseVideoPageBody({
//     super.key,
//     required this.state,
//     this.selectedVideoPath,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(
//         title: 'Choose Video',
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               VideoDescriptionFormField(state: state),
//               const SizedBox(height: 20),
//               if (selectedVideoPath != null)
//                 ThumbnailWidget(videoPath: selectedVideoPath),
//               const SizedBox(height: 20),
//               SelectVideoButton(
//                 state: state,
//               ),
//               const SizedBox(height: 20),
//               VideoUploadBottonWidget(state: state),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
