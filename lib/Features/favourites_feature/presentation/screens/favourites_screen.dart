import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shorts/Features/favourites_feature/data/favourites_model/favourites_model.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shorts/core/service_locator/service_locator.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';
import 'package:video_player/video_player.dart';

import '../../../videos_feature/domain/video_notifiers/video_notifier.dart';
import '../../../videos_feature/presentation/widgets/like_icon.dart';
import '../../../videos_feature/presentation/widgets/thumbnail_notifier.dart';
import '../../domain/favourites_use_case/favourites_use_case.dart';

class FavouritesPage extends StatefulWidget {
  final UserEntity currentUser;

  const FavouritesPage({
    super.key,
    required this.currentUser,
  });

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    super.initState();
    FavouritesCubit.get(context).getFavourites(user: widget.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FavouritesCubit(favouritesUseCase: getIt.get<FavouritesUseCase>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favourites'),
        ),
        body: BlocBuilder<FavouritesCubit, FavouritesState>(
          builder: (context, state) {
            if (state is GetFavoritesLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetFavoritesSuccessState) {
              final favouriteVideos = state.getFavouritesModel;
              return favouriteVideos.isEmpty
                  ? const Center(child: Text('No Favourite Videos Found'))
                  : ListView.builder(
                      itemCount: favouriteVideos.length,
                      itemBuilder: (context, index) {
                        final video = favouriteVideos[index];
                        return VideoListItem(
                          videoEntity: video as FavouritesVideoModel,
                          userModel: widget.currentUser,
                        );
                      },
                    );
            } else {
              return const Center(child: Text('Something went wrong'));
            }
          },
        ),
      ),
    );
  }
}

class VideoListItem extends StatelessWidget {
  final FavouritesVideoModel videoEntity;
  final UserEntity userModel;

  const VideoListItem({
    super.key,
    required this.videoEntity,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoController(videoEntity.videoUrl),
      child: Consumer<VideoController>(
        builder: (context, videoProvider, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              GestureDetector(
                onTap: () => videoProvider.togglePlayPause(),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (videoProvider?.controller?.value.isInitialized ?? false)
                      VideoPlayer(videoProvider.controller!)
                    else
                      ThumbnailNotifier(
                          videoUrl:
                              videoEntity.videoUrl), // Custom thumbnail widget

                    VideoIcons(
                      videoProvider: videoProvider,
                      favouriteEntity: videoEntity,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 20,
                    ),
                    title: Text(videoEntity.user.name),
                    subtitle: Text(videoEntity.description ?? ''),
                    tileColor: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
