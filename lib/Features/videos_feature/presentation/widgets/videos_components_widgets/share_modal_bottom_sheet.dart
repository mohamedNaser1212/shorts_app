// import 'package:flutter/material.dart';
// import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
// import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
// import 'package:shorts/Features/videos_feature/presentation/video_cubit/share_video_cubit/share_videos_cubit.dart';
// import 'package:shorts/core/managers/styles_manager/color_manager.dart';
// import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
// import 'package:shorts/core/widgets/custom_title.dart';
// import 'package:shorts/core/widgets/reusable_text_form_field.dart';
//
// class ShareVideoModalBottomSheet extends StatelessWidget {
//   const ShareVideoModalBottomSheet({
//     super.key,
//     required this.videoEntity,
//   });
//
//   final VideoEntity videoEntity;
//
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController shareTextController = TextEditingController();
//
//     return Padding(
//       padding: MediaQuery.of(context).viewInsets,
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const CustomTitle(
//                 title: 'Share Video',
//                 style: TitleStyle.style20,
//                 color: ColorController.blackColor,
//               ),
//               const SizedBox(height: 10),
//               CustomTextFormField(
//                 label: 'Add a comment...',
//                 controller: shareTextController,
//                 keyboardType: TextInputType.text,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   minimumSize: const Size(double.infinity, 50),
//                 ),
//                 icon: const Icon(Icons.send, color: Colors.white),
//                 label: const CustomTitle(
//                     title: 'Share',
//                     color: ColorController.whiteColor,
//                     style: TitleStyle.style14,),
//                 onPressed: () {
//                   _shareVideo(context, shareTextController.text);
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _shareVideo(BuildContext context, String text) {
//     final currentUser = UserInfoCubit.get(context).userEntity;
//
//     ShareVideosCubit.get(context).shareVideo(
//       videoModel: VideoModel(
//         videoUrl: videoEntity.videoUrl,
//         description: videoEntity.description,
//         sharedBy: currentUser,
//         id: videoEntity.id,
//         thumbnail: videoEntity.thumbnail,
//         user: videoEntity.user,
//       ),
//       text: text.isNotEmpty ? text : '',
//       user: currentUser!,
//     );
//   }
// }
