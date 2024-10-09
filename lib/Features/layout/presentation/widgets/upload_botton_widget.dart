// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:shorts/Features/layout/presentation/screens/choose_video_page.dart';
// import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
// import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
// import 'package:shorts/core/widgets/custom_title.dart';

// class VideoUploadBottonWidget extends StatelessWidget {
//   const VideoUploadBottonWidget({super.key, required this.state});
//   final ChooseVideoPageState state;

//   @override
//   Widget build(BuildContext context) {
//     return ConditionalBuilder(
//       condition: state is! VideoUploadLoadingState,
//       builder: (context) => ElevatedButton(
//         onPressed: () => _uploadVideo(
//           context: context,
//           state: state,
//           titleController: state.titleController,
//         ),
//         child: const CustomTitle(
//           title: 'Upload Video',
//           style: TitleStyle.style18,
//         ),
//       ),
//       fallback: (context) => const CircularProgressIndicator(),
//     );
//   }

//   Future<void> _uploadVideo({
//     required BuildContext? context,
//     required ChooseVideoPageState state,
//     required TextEditingController titleController,
//   }) async {
//     final user = UserInfoCubit.get(context).userEntity;
//     if (state.selectedVideoPath != null && user != null) {
//       await VideoCubit.get(context).uploadVideo(
//         videoPath: state.selectedVideoPath!,
//         description: titleController.text,
//         user: user,

//       );
//     }
//   }
// }
