part of 'favourites_cubit.dart';

class FavouritesState {}

class ToggleFavoriteErrorState extends FavouritesState {
  final String message;
  ToggleFavoriteErrorState({
    required this.message,
  });
}

class ToggleFavouriteSuccessState extends FavouritesState {
  final bool isFavourite;
  ToggleFavouriteSuccessState({
    required this.isFavourite,
  });
}

class ToggleFavoritesLoadingState extends FavouritesState {}

class GetFavoritesErrorState extends FavouritesState {
  final String message;
  GetFavoritesErrorState({
    required this.message,
  });
}

class GetFavoritesSuccessState extends FavouritesState {
  final List<VideoEntity> getFavouritesModel;
  GetFavoritesSuccessState({
    required this.getFavouritesModel,
  });
}

class GetFavoritesLoadingState extends FavouritesState {}
