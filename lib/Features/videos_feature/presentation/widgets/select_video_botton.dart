// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shorts/Features/layout/presentation/screens/choose_video_page.dart';
// import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
// import 'package:shorts/core/widgets/custom_title.dart';

// class SelectVideoButton extends StatefulWidget {
//   final ChooseVideoPageState state;

//   const SelectVideoButton({super.key, required this.state});

//   @override
//   State<SelectVideoButton> createState() => _SelectVideoButtonState();
// }

// class _SelectVideoButtonState extends State<SelectVideoButton> {

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () => _pickVideo(context),
//       child: const CustomTitle(
//         title: 'Select Video',
//         style: TitleStyle.style18,
//       ),
//     );
//   }
//     Future<void> _pickVideo(BuildContext context) async {
//     widget.state.setState(() {
//       widget.state.selectedVideoPath = null;
//     });
//     final result = await context.read<VideoCubit>().pickVideo();
//     if (result != null) {
//       widget.state.setState(() {
//         widget.state.selectedVideoPath = result;
//       });
//     }
//   }
// }
