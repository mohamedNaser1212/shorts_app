import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/layout/presentation/screens/home_screen.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/upload_videos_cubit/upload_videos_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/preview_Screen_body.dart';
import 'package:shorts/core/functions/navigations_functions.dart';
import 'package:shorts/core/user_info/cubit/user_info_cubit.dart';
import 'package:shorts/core/widgets/custom_progress_indicator.dart';
import '../../../../../core/widgets/custom_app_bar.dart';

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
    return CustomProgressIndicator(
      isLoading: state is VideoUploadLoadingState,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Preview',
        ),
        body: PreviewScreeBody(
          previewState: this,
          thumbnailFile: widget.thumbnailFile,
        ),
      ),
    );
  }

  void _listener(context, state) {
    if (state is VideoUploadedSuccessState) {
      NavigationManager.navigateAndFinish(
        context: context,
        screen: HomeScreen(
          currentUser: UserInfoCubit.get(context).userEntity!,
        ),
      );
    }
  }
}
