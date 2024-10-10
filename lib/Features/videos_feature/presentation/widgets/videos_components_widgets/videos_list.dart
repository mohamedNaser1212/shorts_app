import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shorts/Features/favourites_feature/domain/favourites_entity/favourite_entitiy.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_list_body.dart';

import '../../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../../../../../core/video_notifiers/video_notifier.dart';
import '../../../domain/video_entity/video_entity.dart';

class VideoListItem extends StatelessWidget {
  final VideoEntity videoEntity;
  final UserEntity userModel;
  final FavouritesEntity? favouriteEntity;

  const VideoListItem({
    super.key,
    required this.videoEntity,
    required this.userModel,
    this.favouriteEntity,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoController(videoEntity.videoUrl),
      child: Consumer<VideoController>(
        builder: _builder,
      ),
    );
  }

  Widget _builder(context, videoProvider, child) {
    return VideoListBody(
      videoEntity: videoEntity,
      videoProvider: videoProvider,
    );
  }
}
