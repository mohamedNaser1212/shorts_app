import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/share_modal_bottom_sheet.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_icon_widget.dart';

class ShareIconWidget extends StatelessWidget {
  const ShareIconWidget({super.key, required this.videoEntity});
  final VideoEntity videoEntity;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showShareModal(context),
      icon: const CustomIconWidget(
       icon:  Icons.share,
        color: ColorController.whiteColor,
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
        return ShareVideoModalBottomSheet(videoEntity: videoEntity); 
      },
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
