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
      onPressed: () => _showShareModal(context),
      icon: const Icon(
        Icons.share,
        color: Colors.white,
        size: 35,
      ),
    );
  }

  void _showShareModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        TextEditingController shareTextController = TextEditingController();
        return Padding(
          padding: MediaQuery.of(context).viewInsets, 
          
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Share Video',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: shareTextController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    icon: const Icon(Icons.send, color: Colors.white),
                    label: const Text(
                      'Share',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      _shareVideo(context, shareTextController.text);
                      Navigator.pop(context);
                      
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _shareVideo(BuildContext context, String text) {
    final currentUser = UserInfoCubit.get(context).userEntity;

    UploadVideosCubit.get(context).shareVideo(
      videoModel: VideoModel(
        videoUrl: videoEntity.videoUrl,
        description: videoEntity.description,
        sharedBy: currentUser,
        id: videoEntity.id,
        thumbnail: videoEntity.thumbnail,
        user: videoEntity.user,
      ),
      text: text.isNotEmpty ? text : '',
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
