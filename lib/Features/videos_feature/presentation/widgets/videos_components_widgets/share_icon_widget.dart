import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/data/model/video_model.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/upload_videos_cubit/upload_videos_cubit.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';

class ShareIconWidget extends StatelessWidget {
  const ShareIconWidget({super.key, required this.videoEntity});
  final VideoEntity videoEntity;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _shareOnPressed(context: context),
      icon: const Icon(
        Icons.share,
        color: Colors.white,
        size: 35,
      ),
    );
  }

  void _shareOnPressed({
    required BuildContext context,
  }) async {
    final  currentUser = UserInfoCubit.get(context).userEntity;

    UploadVideosCubit.get(context).shareVideo(
      videoModel: VideoModel(
        videoUrl: videoEntity.videoUrl,
        description: videoEntity.description,
        sharedBy: currentUser, id: videoEntity.id,
        thumbnail: videoEntity.thumbnail,
        user: videoEntity.user,
      ),
      text: 'Check out this video',
      user: currentUser!,  
    );
  }
}


    // NavigationManager.navigateTo(
    //   context: context,
    //   screen: PreviewScreen(
    //     outputPath: videoEntity.videoUrl,
    //   ),
    // );


  // void _shareOnPressed({required BuildContext context}) async {
  //   try {
  //     await Share.share(
  //       videoEntity.videoUrl,
  //       subject: videoEntity.description,
  //     );
  //   } catch (error) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Error sharing the video')),
  //     );
  //   }
  // }
