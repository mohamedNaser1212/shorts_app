import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/screens/videos_list.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      body: BlocConsumer<FavouritesCubit, FavouritesState>(
        listener: (context, state) {
          if (state is GetFavoritesErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error loading favourites')),
            );
          }
        },
        builder: (context, state) {
          if (state is GetFavoritesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetFavoritesSuccessState) {
            final favouriteVideos = state.getFavouritesModel;
            return favouriteVideos.isEmpty
                ? const Center(child: Text('No Favourite Videos Found'))
                : PageView.builder(
                    itemCount: favouriteVideos.length,
                    itemBuilder: (context, index) {
                      final favouriteEntity = favouriteVideos[index];
                      final videoEntity = VideoEntity(
                        id: favouriteEntity.id,
                        videoUrl: favouriteEntity.videoUrl,
                        description: favouriteEntity.description,
                        user: favouriteEntity.user,
                        comments: [],
                        thumbnail: favouriteEntity.thumbnail,
                      );

                      return VideoListItem(
                        favouriteEntity: favouriteEntity,
                        videoEntity: videoEntity,
                        userModel: widget.currentUser,
                      );
                    },
                  );
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
