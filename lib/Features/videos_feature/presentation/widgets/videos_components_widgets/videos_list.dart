import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shorts/Features/favourites_feature/domain/favourites_entity/favourite_entitiy.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/video_list_body.dart';

import '../../../../../core/video_controller/video_controller.dart';
import '../../../domain/video_entity/video_entity.dart';

class VideoListItem extends StatelessWidget {
  final VideoEntity videoEntity;
  final FavouritesEntity? favouriteEntity;
  final bool? fromProfile;

  const VideoListItem({
    super.key,
    required this.videoEntity,
    this.favouriteEntity,
    this.fromProfile,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoController(
          videoUrl: favouriteEntity?.videoUrl ?? videoEntity.videoUrl),
      child: Consumer<VideoController>(
        builder: _builder,
      ),
    );
  }

  Widget _builder(context, videoProvider, child) {
    // print(videoEntity.videoUrl);

    return VideoListBody(
      videoEntity: videoEntity,
      fromProfile: fromProfile,
      videoController: videoProvider,
      // favouriteEntity: favouriteEntity,
    );
  }
}
