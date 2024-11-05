import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorts/Features/favourites_feature/presentation/cubit/get_favourites_cubit/favourites_cubit.dart';
import 'package:shorts/Features/favourites_feature/presentation/widgets/favourites_screen_body.dart';
import 'package:shorts/core/functions/toast_function.dart';
import 'package:shorts/core/managers/styles_manager/color_manager.dart';
import 'package:shorts/core/widgets/custom_app_bar.dart';
import 'package:shorts/core/widgets/custom_title.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorController.blackColor,
      appBar: const CustomAppBar(
        title: 'Favourites',
        backColor: Colors.transparent,
      ),
      body: BlocConsumer<FavouritesCubit, FavouritesState>(
        listener: (context, state) {
          if (state is GetFavoritesErrorState) {
            ToastHelper.showToast(
              message: state.message,
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
                      color: ColorController.whiteColor,
                    ),
                  )
                : FavouritesScreenBody(
                    favouriteVideos: favouriteVideos,
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
