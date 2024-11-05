import 'package:flutter/material.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';
import 'package:shorts/Features/favourites_feature/domain/favourites_entity/favourite_entitiy.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/get_videos_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/videos_list.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

class FavouritesScreenBody extends StatelessWidget {
  FavouritesScreenBody({
    super.key,
    required this.favouriteVideos,
    required this.currentUser,
  });

  final List<FavouritesEntity> favouriteVideos;
  final UserEntity currentUser;

  final PageController _pageController = PageController();

  final int pageSize = 0;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: favouriteVideos.length,
      itemBuilder: (context, index) {
        final favouriteEntity = favouriteVideos[index];
        final videoEntity = VideoCubit.get(context).videos[index];
        final isShared = videoEntity.sharedBy != null;

        CommentsCubit.get(context).getCommentsCount(
          videoId: videoEntity.id,
        );
        CommentsCubit.get(context).getComments(
          videoId: videoEntity.id,
          page: 0,
        );
        return VideoListItem(
          favouriteEntity: favouriteEntity,
          videoEntity: videoEntity,
          isShared: isShared,
          userModel: currentUser,
        );
      },
    );
  }
}
