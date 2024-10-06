import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shorts/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:shorts/Features/videos_feature/presentation/video_cubit/video_cubit.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/videos_list.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';
import 'package:shorts/core/widgets/custom_app_bar.dart';
import 'package:shorts/core/widgets/custom_title.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({
    super.key,
    required this.currentUser,
  });
  final UserEntity currentUser;

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
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
      appBar: CustomAppBar(title: 'Favourites'),
      body: BlocConsumer<FavouritesCubit, FavouritesState>(
        listener: (context, state) {
          if (state is GetFavoritesErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: CustomTitle(
                  title: 'Something went wrong',
                  style: TitleStyle.style18,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is GetFavoritesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetFavoritesSuccessState) {
            final favouriteVideos = state.getFavouritesModel;
            return favouriteVideos.isEmpty
                ? const Center(
                    child: CustomTitle(
                      title: 'No Favourite Videos Found',
                      style: TitleStyle.style18,
                    ),
                  )
                : PageView.builder(
                    itemCount: favouriteVideos.length,
                    itemBuilder: (context, index) {
                      final favouriteEntity = favouriteVideos[index];
                      final videoEntity = VideoCubit.get(context).videos[index];

                      return VideoListItem(
                        favouriteEntity: favouriteEntity,
                        videoEntity: videoEntity,
                        userModel: widget.currentUser,
                      );
                    },
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorController.whiteColor,
              ),
            );
          }
        },
      ),
    );
  }
}
