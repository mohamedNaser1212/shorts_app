import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/get_favourites_cubit/favourites_cubit.dart';
import 'package:shorts/Features/favourites_feature/presentation/widgets/favourites_screen_body.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/user_info/domain/user_entity/user_entity.dart';
import 'package:shorts/core/widgets/custom_app_bar.dart';
import 'package:shorts/core/widgets/custom_title.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({
    super.key,
    required this.currentUser,
  });
  final UserEntity currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Favourites',
        backColor: Colors.transparent,
      ),
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
                : FavouritesScreenBody(favouriteVideos: favouriteVideos, currentUser: currentUser);
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
