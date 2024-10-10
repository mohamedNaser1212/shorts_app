import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/comments_cubit.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_uploading_widgets/user_profile_section.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_icons_section.dart';
import 'package:shorts/core/video_notifiers/video_notifier.dart';


class VideoContentsScreen extends StatefulWidget {
  const VideoContentsScreen({
    super.key,
    required this.videoEntity,
    required this.videoProvider,
  });

  final VideoEntity videoEntity;
  final VideoController videoProvider;

  @override
  State<VideoContentsScreen> createState() => VideoContentsScreenState();
}

class VideoContentsScreenState extends State<VideoContentsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentsCubit, CommentsState>(
      listener: _commentsListener,
      builder: _builder,
    );
  }

  Widget _builder(context, state) {
    return BlocConsumer<VideoCubit, VideoState>(
      listener: _videoListener,
      builder: _videoCubitBuilder,
    );
  }

  void _videoListener(context, state) {}

  Widget _videoCubitBuilder(context, state) {
    return BlocConsumer<FavouritesCubit, FavouritesState>(
      listener: _favouritesListener,
      builder: _favouriteCubitBuilder,
    );
  }

  void _favouritesListener(context, state) {}

  Widget _favouriteCubitBuilder(context, state) {
    return Stack(
      children: [
        UserProfileSection(
          state: this,
        ),
        VideoIconsSection(
          videoEntity: widget.videoEntity,
          videoProvider: widget.videoProvider,
        ),
      ],
    );
  }

  void _commentsListener(context, state) {}
}
