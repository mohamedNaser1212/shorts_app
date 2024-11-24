import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/upload_videos_cubit/upload_videos_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/preview_Screen_body.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';

import '../../../../../core/widgets/custom_snack_bar.dart';

// ignore: must_be_immutable
class PreviewScreen extends StatefulWidget {
  PreviewScreen({super.key, required this.outputPath, this.thumbnailFile});

  late String outputPath;
  final File? thumbnailFile;

  @override
  State<PreviewScreen> createState() => PreviewScreenState();
}

class PreviewScreenState extends State<PreviewScreen> {
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadVideosCubit, UploadVideosState>(
      listener: _listener,
      builder: _builder,
    );
  }

  Widget _builder(context, state) {
    return Scaffold(
      backgroundColor: ColorController.blackColor,
      body: PreviewScreeBody(
        previewState: this,
        thumbnailFile: widget.thumbnailFile,
      ),
    );
  }

  void _listener(context, state) {
    if (state is VideoUploadLoadingState) {
      Navigator.pop(context);
      showSnackBar(
        message:
            "Video is now uploading, we will notify you when upload is complete",
        context: context,
      );
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   showCloseIcon: true,
      //   backgroundColor: ColorController.greenAccent,
      //   dismissDirection: DismissDirection.up,
      //   behavior: SnackBarBehavior.floating,
      //   margin: EdgeInsets.all(20),
      //   padding: EdgeInsets.all(10),
      //   content: DefaultTextStyle(
      //     style: TextStyle(color: ColorController.whiteColor, fontSize: 16),
      //     child: Text(
      //         "Video is now uploading, we will notify you when upload is complete"),
      //   ),
      // ));
    }
    // } else if (state is VideoUploadedSuccessState) {
    //   //   print(state.videoEntity.);
    //
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Video Uploaded Successfully'),
    //       backgroundColor: ColorController.greenAccent,
    //       duration: const Duration(seconds: 20),
    //       action: SnackBarAction(
    //         label: 'Show',
    //         textColor: Colors.white,
    //         onPressed: () {
    //           NavigationManager.navigateTo(
    //             context: context,
    //             screen: VideoListItem(videoEntity: state.videoEntity),
    //           );
    //         },
    //       ),
    //     ),
    //   );
    //
    //   NavigationManager.navigateAndFinish(
    //     context: context,
    //     screen: const LayoutScreen(),
    //   );
    // }
  }
}
