import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/comments_feature/presentation/cubit/get_comments_cubit/comments_cubit.dart';
import 'package:shorts/Features/favourites_feature/domain/favourites_entity/favourite_entitiy.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/get_videos_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_components_widgets/videos_list.dart';
import 'package:shorts/core/functions/toast_function.dart';
import 'package:shorts/core/widgets/custom_title.dart';

class FavouritesScreenBody extends StatefulWidget {
  const FavouritesScreenBody({
    super.key,
    required this.favouriteVideos,
  });

  final List<FavouritesEntity> favouriteVideos;

  @override
  State<FavouritesScreenBody> createState() => _FavouritesScreenBodyState();
}

class _FavouritesScreenBodyState extends State<FavouritesScreenBody> {
  late PageController _pageController;

  final int pageSize = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoCubit, VideoState>(
      builder: (context, state) {
        if (state is GetVideosError) {
           ToastHelper.showToast(
            message: state.message,
          );
        }
        if (state is GetVideoSuccess) {
          return PageView.builder(
            controller: _pageController,
            itemCount: widget.favouriteVideos.length,
            itemBuilder: (context, index) {
              final favouriteEntity = widget.favouriteVideos[index];
              final videoEntity = state.videos[index];
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
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
          
        );
      },
    );
  }
}
