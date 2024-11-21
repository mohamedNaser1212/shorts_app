import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/get_videos_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_action_buttons.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_owner_info.dart';

class VideoContentsScreen extends StatefulWidget {
  const VideoContentsScreen({
    super.key,
    required this.videoEntity,
    // required this.isShared,
  });

  final VideoEntity videoEntity;
  // final bool isShared;

  @override
  State<VideoContentsScreen> createState() => VideoContentsScreenState();
}

class VideoContentsScreenState extends State<VideoContentsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) => BlocBuilder<VideoCubit, VideoState>(
        builder: _videoCubitBuilder,
      ),
    );
  }

  Widget _videoCubitBuilder(context, state) {
    return Stack(
      children: [
        VideoOwnerInfo(
          state: this,
        ),
        VideoActionIcons(
          videoEntity: widget.videoEntity,
        ),
      ],
    );
  }
}
